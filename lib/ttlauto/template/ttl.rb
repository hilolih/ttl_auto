# -*- encoding: utf-8 -*-
#
# TtlAuto::Ttl
#
# erbを使って、ttlマクロを生成する
#
module TtlAuto
    class Ttl < Template
        attr_reader :path, :record

        def initialize record, category, cmd_templates={}
            super(record, category, cmd_templates)
            @path = "#{OUT}/#{category}".downcase
        end

        def bind
            unless @cmd_templates.empty?
                @rd.replace_macro @cmd_templates
            end
            # set valid public keyfile path
            if @rd.keyfile?
                @rd.set_keyfile_path @category
            end
            # set valid inifile path
            if @rd.inifile?
                @rd.set_inifile_path @category
            end
            #
            # on TtlAuto::Template
            # ファイルへの書き出し
            #
            generate_macro()
        end

    end
end
