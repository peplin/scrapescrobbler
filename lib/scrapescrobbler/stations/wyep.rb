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

        table = doc.at("div#center_right")
        breaks = table/"tr"/"td"
        songs = []
        [table/"td.now_playing", table/"td.odd_row" - breaks, table/"td.even_row" - breaks].each do |row|
          next unless row.length != 0
          playlist_entries = row.collect do |cell|
            cell.inner_html
          end
          songs = playlist_entries.chunk(5).collect do |entry|
            time = entry[0] == "NOW PLAYING" ? Time.now : Time.parse(entry[0])
            Scrapescrobbler::Song.new :time => time, :artist => entry[1],
                :title => entry[2], :album => entry[3], :station => Wyep::NAME
          end
        end
        songs
      end
    end
  end
end
