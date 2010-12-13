require 'lastfm'

module Scrapescrobbler
  class Listener
    attr_accessor :lastfm, :station, :started

    def initialize(station)
      @lastfm = Listener.authenticate
      @station = ::Scrapescrobbler::Stations.const_get(station.classify)
    end

    def listen
      raise if @started
      @started = DateTime.now
    end

    def update
      playlist = Stations::Wyep::playlist
      if playlist and playlist.length > 0 then
        @now_playing = playlist.first
        playlist.each do |song|
          saved = song.save
          self.scrobble(song) if saved
        end
      end
    end

    def scrobble song
      puts "Scrobbling #{song} @ #{song.time || Time.now}"
      @lastfm.track.scrobble(song.artist, song.title, song.album,
          song.time.utc.to_i || Time.now.utc.to_i)
    end

    def now_playing
      update if not @now_playing
      @now_playing
    end

    private

    def self.authenticate
      if not Config['session']
        CLI.authenticate
      end

      lastfm = Lastfm.new Config['api_key'], Config['api_secret']
      lastfm.session = Config['session']
      lastfm
    end
  end
end
