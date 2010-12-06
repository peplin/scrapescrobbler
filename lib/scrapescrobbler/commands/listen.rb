module Scrapescrobbler
  module CLI
    def listen
      listener = Listener.new unused_args
      listener.listen
      while true
        listener.update
        sleep 60
      end
    end
  end
end
