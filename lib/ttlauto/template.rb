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
            @category = category
            @cmd_templates = cmd_templates
            @rd = TtlAuto::Record.new(record)
        end

        def timestamp
            Time.now.strftime('%Y/%m/%d %H:%M:%S')
        end

        def generate_macro
            record = @rd.body
            description = @rd.description
            if self.class.to_s == "TtlAuto::Ttl"
                encoding = "windows-31j"
                filename = "#{@path}/#{record['name'].downcase}.ttl"
                template = TEMPLATE
            elsif self.class.to_s == "TtlAuto::Expect"
                encoding = "utf-8"
                filename = "#{@path}/#{record['name'].downcase}"
                template = EXPECT_TEMPLATE
            end
            #
            # ファイル書き出し処理
            #
            FileUtils.mkdir_p @path unless File.exists?(@path)
            open( filename, "w:#{encoding}"){|f|
                f.puts ERB.new(IO.read(template), nil, '-').result(binding)
            }
        end


    end
end

