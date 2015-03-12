# -*- encoding: utf-8 -*-
module TtlAuto
  class Macro
    #include Constant
    #include TtlAuto::Log
    attr_reader :yaml, :command_templates
    attr_accessor :definitions, :command_macros, :rootdir, :private_keydir, :inidir
    
    def initialize &block
      @rootdir = "./out"
      @inidir  = "ini"
      instance_eval(&block) if block_given?
    end

    def out!
      servers = TtlAuto::Yaml.new @definitions 
      binding.pry
    end
  end
end
