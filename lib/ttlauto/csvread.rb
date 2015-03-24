require 'csv'
module TtlAuto
  class Csv
    attr_reader :servers, :categories
    def read file
      @servers = []
      CSV.open( file, "r" ){ |csv|
        csv.each do |row|
          ttl = TtlAuto::TTL.new
          ttl.filename = "#{row[0].strip}.ttl"
          ttl.dataname = "#{row[0].strip}.dat"
          ttl.server   = row[1].strip
          ttl.user     = row[2].strip
          ttl.pass     = row[3].strip
          ttl.encoding = row[4].strip
          ttl.protocol = row[5].strip
          ttl.category = row[6].strip
          ttl.rootpass = row[7] ? row[7].strip : ""

          @servers << ttl
        end
      }
    end

    def set_categories
      @categories = {}
      @servers.each do |srv|
        @categories[srv.category] ||= []
        @categories[srv.category] << srv
      end
    end
  end
end
