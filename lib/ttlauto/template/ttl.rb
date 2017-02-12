# -*- encoding: utf-8 -*-
#
# TtlAuto::Ttl
#
# erbを使って、ttlマクロを生成する
#
module TtlAuto
  class Ttl < Template
    attr_reader :path, :record

    def bind
      rd = TtlAuto::Record.new(@record)
      log_debug  "#{@path}/#{record['name']}.ttl"
      unless @cmd_templates.empty?
        rd.replace_macro @cmd_templates
      end
      # set valid public keyfile path
      if rd.keyfile?
        rd.set_keyfile_path @category
      end
      # set valid inifile path
      if rd.inifile?
        rd.set_inifile_path @category
      end
      #
      record = rd.body
      description = rd.description
      FileUtils.mkdir_p @path unless File.exists?(@path)
      open( "#{@path}/#{record['name'].downcase}.ttl", "w:windows-31j"){|f|
        f.puts ERB.new(IO.read(TEMPLATE), nil, '-').result(binding)
      }
    end

  end
end
