require 'scrapescrobbler'
require 'spec_helper'

module Scrapescrobbler
  describe CLI do
    include HelperMethods

    describe "list" do
      before :each do
        mockit
      end

      it "should list all available stations" do
        invoke 'stations'
        $stdin.should include(Stations.constants.collect do |const|
            station = Stations.const_get(const)
            if station != Stations::Station then
              station::NAME
            end
          end.compact)
      end
    end
  end
end
