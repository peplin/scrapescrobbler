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
      puts "Scrobbling #{song} @ #{Time.now}"
      if song.album then
        @lastfm.track.scrobble song.artist, song.title, song.album
      else
        @lastfm.track.scrobble song.artist, song.title
      end
    end

    def now_playing
      update if not @now_playing
      @now_playing
    end

    private

    def self.authenticate
      if not Config['token']
        CLI.authenticate
        exit
      else
        lastfm = Lastfm.new Config['api_key'], Config['api_secret']
        lastfm.session = lastfm.auth.get_session(Config['token'])
        lastfm
      end
    end
  end
end
