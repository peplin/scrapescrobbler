require 'hpricot'
require 'open-uri'

station = Scrapescrobbler::Station.first(:name => "WYEP")
puts station
if station.eql? nil then
  station = Scrapescrobbler::Station.create :name => "WYEP", :frequency => "91.3"
end

doc = open("http://wyep.org/playlist/") { |f| Hpricot(f) }

table = doc.at("div#center_right")
breaks = table/"tr"/"td"
[table/"td.now_playing", table/"td.odd_row" - breaks, table/"td.even_row" - breaks].each do |row|
  next unless row.length != 0
  playlist_entries = row.collect do |cell|
    cell.inner_html
  end
  playlist_entries.chunk(5).each do |entry|
    song = Scrapescrobbler::Song.create :time => Time.parse(entry[0]),
        :artist => entry[1], :title => entry[2], :album => entry[3],
        :station => station
    puts song
  end
end

puts Scrapescrobbler::Song.all(:order => :time)
