module Scrapescrobbler
  class Song
    include DataMapper::Resource
    property :id, Serial
    property :time, DateTime, :required => true
    property :artist, String, :required => true
    property :title, String, :required => true
    property :album, String
    property :station, String, :required => true

    validates_uniqueness_of :time, :scope => :station
  end
end
