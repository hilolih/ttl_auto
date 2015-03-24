require 'psych'
module TtlAuto
  class Yaml
    attr_reader :records, :categories
    def read file
      str = file.read
      ast = Psych.parse str
      @records = ast.to_ruby
      #@records = YAML.load(str)
    end

    def set_categories
      @categories = {}
      @records.each do | record |
        @categories[record["category"]] ||= []
        @categories[record["category"]] << record
      end
    end
  end
end
