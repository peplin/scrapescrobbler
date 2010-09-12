require 'lastfm'

module Scrapescrobbler
  class Listener
    attr_accessor :lastfm, :station, :started

    def initialize(station)
      @station = station
      @lastfm = Listener.authenticate
    end

    def listen
      raise if @started
      @started = DateTime.now
    end

    def update
    end

    def now_playing
    end

    private

    def self.authenticate
      lastfm = Lastfm.new Config['api_key'], Config['api_secret']
      lastfm.session = lastfm.auth.get_session(lastfm.auth.get_token)
      lastfm
    end
  end
end
