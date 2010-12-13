module Scrapescrobbler
  module CLI
    def authenticate
      lastfm = Lastfm.new Config['api_key'], Config['api_secret']
      if not Config['token']
        token = lastfm.auth.get_token
        say "Go to http://www.last.fm/api/auth/?api_key=#{Config['api_key']}&token=#{token} to allow scrapescrobbler to access your last.fm account."
        Config.update! 'token' => token, 'session' => nil
        exit
      elsif not Config['session']
        Config.update! 'session' => lastfm.auth.get_session(Config['token'])
      end
    end
  end
end
