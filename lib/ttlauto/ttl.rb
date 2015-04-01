# -*- encoding: utf-8 -*-
require 'erb'
module TtlAuto
  class Ttl
    include Constant
    include TtlAuto::Log
    attr_reader :path, :record

    def initialize record, category, cmd_templates={}
      @path = "#{OUT}/#{category}"
      @record = record
      @cmd_templates = cmd_templates
    end

    def bind
      rd = TtlAuto::Record.new(@record)
      log_debug  "#{@path}/#{record['name']}.ttl"
      unless @cmd_templates.empty?
        rd.replace_macro @cmd_templates
      end
      # set valid public keyfile path
      if rd.keyfile?
        rd.set_keyfile_path
      end
      # set valid inifile path
      if rd.inifile?
        rd.set_inifile_path
      end
      record = rd.body
      description = rd.description
      FileUtils.mkdir_p @path unless File.exists?(@path)
      open( "#{@path}/#{record['name']}.ttl", "w:windows-31j"){|f|
        f.puts ERB.new(IO.read(TEMPLATE), nil, '-').result(binding)
      }
    end

    private

    def timestamp
      Time.now.strftime('%Y/%m/%d %H:%M:%S')
    end

  end
end
