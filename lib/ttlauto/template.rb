module TtlAuto
    class Template
        include Constant
        include TtlAuto::Log
        def initialize record, category, cmd_templates={}
            @path = "#{OUT}/#{category}".downcase
            @record = record
            @category = category
            @cmd_templates = cmd_templates
        end

        def timestamp
            Time.now.strftime('%Y/%m/%d %H:%M:%S')
        end


    end
end

