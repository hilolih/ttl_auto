# -*- encoding: utf-8 -*-
#
# TtlAuto::Expect
#
# expectを使って、expectマクロを生成する
#
module TtlAuto
    class Expect < Template
        def initialize record, category, cmd_templates={}
            super(record, category, cmd_templates)
            @path = "#{EXPECT_OUT}".downcase
        end

        def bind
            unless @cmd_templates.empty?
                @rd.replace_macro @cmd_templates
            end
            #
            # on TtlAuto::Template
            # ファイルへの書き出し
            #
            generate_macro()
        end
    end
end

