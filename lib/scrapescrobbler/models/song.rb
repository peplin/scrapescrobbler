module Scrapescrobbler
  class Song
    include DataMapper::Resource
    property :id, Serial
    property :time, DateTime
    property :artist, String
    property :title, String
    property :album, String
    belongs_to :station

    validates_uniqueness_of :time, :scope => :station_id
  end
end
