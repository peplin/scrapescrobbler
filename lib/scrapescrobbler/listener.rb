require 'lastfm'

module Scrapescrobbler
  class Listener
    attr_accessor :lastfm, :station, :started

    def initialize(station)
      @station = station
      @lastfm = Lastfm.new Config['api_key'], Config['api_secret']
      @lastfm.session = @lastfm.auth.get_session(lastfm.auth.get_token)
    end

    def listen
    end

    def update
    end

    def now_playing
    end
  end
end
