require 'scrapescrobbler'

module Scrapescrobbler
  module Stations
    class Station
      def playlist count
        raise NotImplementedError
      end
    end
  end
end
