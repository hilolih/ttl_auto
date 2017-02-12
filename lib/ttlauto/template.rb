# -*- encoding: utf-8 -*-
#
# TtlAuto::Template
#
# テンプレートマクロを生成する
# Ttl, Expectのスーパークラス
#
require 'erb'
module TtlAuto
    class Template
        include Constant
        include TtlAuto::Log
        def initialize record, category, cmd_templates={}
            @path = "#{OUT}/#{category}".downcase
            #@record = record
            @category = category
            @cmd_templates = cmd_templates
            #@rd = TtlAuto::Record.new(record)
            @rd = TtlAuto::Record.new(record)
        end

        def timestamp
            Time.now.strftime('%Y/%m/%d %H:%M:%S')
        end

    end
end

