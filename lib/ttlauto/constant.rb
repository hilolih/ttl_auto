module TtlAuto
  module Constant
    dir = File.dirname( File.dirname( File.dirname(__FILE__) ) )
    OUT = "./out"
    PEM = "lib/pem"
    INI = 'lib\\inifile'
    TEMPLATE = "#{dir}/templates/utf8/template.ttl"
  end
end
