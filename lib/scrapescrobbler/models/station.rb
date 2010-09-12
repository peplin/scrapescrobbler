module Scrapescrobbler
  class Station
    include DataMapper::Resource
    self.raise_on_save_failure = true

    property :id, Serial
    property :frequency, String
    property :name, String
    property :fm, Boolean, :default => true
    has n, :songs

    validates_uniqueness_of :name
  end
end
