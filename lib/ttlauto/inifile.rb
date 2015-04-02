# -*- encoding: utf-8 -*-
module TtlAuto
  class Inifile
    include Constant
    include TtlAuto::Log
    def self.create
      puts "create #{INI}\\*.INI"
      Dir.glob("#{OUTLIB}/*.INI").each do |inifile|
        base = File.basename( inifile, ".INI" )
        open( inifile, 'r' ){|f|
          open( "#{OUTLIB}/#{base}_SSH.INI", "w" ){|out| inout(f, out, ssh) }
          f.rewind
          open( "#{OUTLIB}/#{base}_TELNET.INI", "w" ){|out| inout(f, out, telnet) }
        }
      end
    end

    private 

    def self.inout fin, fout, protocol
      fout.puts fin.read.gsub(regex, protocol)
    end

    def self.regex
      /Enabled=[01]/
    end
    
    def self.ssh
      "Enabled=1"
    end

    def self.telnet
      "Enabled=0"
    end
  end
end

