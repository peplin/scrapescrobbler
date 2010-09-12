require 'scrapescrobbler'
require 'spec_helper'

module Scrapescrobbler
  describe CLI do
    include HelperMethods

    describe "list" do
      before :each do
        mockit
      end

      before do
        Station.create :name => "WYEP", :frequency => "91.3"
        Station.create :name => "WDUQ", :frequency => "90.1"
      end

      it "should list all available stations" do
        invoke 'stations'
        Station.all.each do |station|
          $stdin.should include(Station.all.collect do |station| station.name end)
        end
      end
    end
  end
end
