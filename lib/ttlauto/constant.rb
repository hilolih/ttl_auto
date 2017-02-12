module TtlAuto
  module Constant
    dir = File.dirname( File.dirname( File.dirname(__FILE__) ) )
    OUT = "./out"
    OUTLIB = "./out/lib/inifile"
    PEM = "lib/pem"
    INI = 'lib\\inifile'
    TEMPLATE = "#{dir}/templates/utf8/template.ttl"
    EXPECT_OUT = "~/bin/out"
    EXPECT_TEMPLATE = "#{dir}/templates/utf8/expect.erb"
  end
end
