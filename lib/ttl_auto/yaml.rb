# -*- encoding: utf-8 -*-
require 'psych'
module TtlAuto
  class Yaml
    attr_reader :records, :categories

    def initialize file
      read open(file, "r")
    rescue => e
      puts e
      exit 1
    end

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

