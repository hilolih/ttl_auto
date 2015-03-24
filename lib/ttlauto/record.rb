# -*- encoding: utf-8 -*-
module TtlAuto
  class Record
    include Constant
    include TtlAuto::Log
    attr_reader :body, :defines
    def initialize record
      @body = record
      @defines = record['define']
    end

    def description
      parse_description @body['description']
    end

    def replace_macro templates
      templates.each do |tmpl|
        if tmpl['type'] == "command_macro"
          target = {"call_templates" => tmpl['name']}
          @body = replace_iter @body, target, tmpl["commands"]
        end
      end
    end

    def keyfile?
      @body['define'].any?{|d| d['publickey']}
    end

    def set_keyfile_path
      @body['define'].each do |d|
        if d['publickey']
          pem = "#{PEM}/#{File.basename(d['publickey'])}"
          d['publickey'] = depth.times.reduce(pem){|n| File.join('../', n)}
          log_info d['publickey']
        end
      end
    end

    private

    def depth
      @body['category'].count('/') + 1
    end

    def replace_iter obj, target, replace
      if obj.class == Array
        if obj.include?( target )
          return obj.map{|el|
            if el == target
              replace
            else
              replace_iter el, target, replace
            end
          }.flatten
        else
          return obj.map{|el| replace_iter el, target, replace }
        end
      elsif obj.class == Hash
        return Hash[obj.map{|k, v| [k, replace_iter(v , target, replace)] }]
      else
        return obj
      end
    end

    def parse_description obj
      if obj.class == Array
        obj.join("\n;            ")
      else
        obj
      end
    end

  end
end
