require 'hpricot'
require 'open-uri'
require 'scrapescrobbler/stations/base'

module Scrapescrobbler
  module Stations
    class Wyep < Station
      NAME = "WYEP"
      FREQUENCY = "91.3"
      FM = true
      PLAYLIST_URL = "http://wyep.org/playlist/"

      def self.playlist
        doc = open(PLAYLIST_URL) { |f| Hpricot(f) }

        table = doc.at("table.playlist")
        breaks = Array.new(table/"tr"/"td.group")
        songs = (table/"tr.odd" + table/"tr.even" - breaks).collect do |row|
          fields = row/"td"
          next if breaks.include? fields[0]
          field_data = (fields/"p").collect do |field| field.inner_html end
          time = field_data[0] == "NOW PLAYING" ? Time.now :
              Time.parse(field_data[0])
          Scrapescrobbler::Song.new :time => time, :artist => field_data[1],
              :title => field_data[2], :album => field_data[3], :station => Wyep::NAME
        end
        songs
      end
    end
  end
end
