# -*- encoding: utf-8 -*-
module TtlAuto
  class Exe
    include Constant
    include TtlAuto::Log
    attr_reader :yaml, :command_templates
    def initialize file, templates=nil
      @yaml = TtlAuto::Yaml.new
      @yaml.read file
      @yaml.set_categories
      unless templates.nil?
        yml = TtlAuto::Yaml.new
        @command_templates = yml.read templates
      end
    end

    def run
      @yaml.records.each do |record|
        run_each_parents record
      end
    end

    def ping
      return_code = 0
      server_list.each do |server|
        tcp = TtlAuto::Ping.new( server )
        if tcp.scan?
          log_info "#{server[:server]}:#{server[:port]} is enable to connect"
        else
          log_error "!!! #{server[:server]}:#{server[:port]} is NOT enable to connect !!!"
          return_code = 1
        end
      end
      return_code
    end

    private

    def server_list
      list = []
      @yaml.records.each do |record|
        list << record['define'].map{|hash| {server: hash['server'], 
                                             port: hash['protocol'],
                                             ping: (hash['ping'].nil? ? true : hash['ping'])
        } }
      end
      list.flatten!.uniq!
      list.select{|item| item[:ping] }
    end

    def run_each_parents record
      @command_templates ||= {}
      parents( record['category'] ).each do |v|
        Ttl.new( record, v, @command_templates ).bind
      end
    end

    def parents obj
      if obj.class == Array
        obj
      else
        [ obj ]
      end
    end
  end
end
