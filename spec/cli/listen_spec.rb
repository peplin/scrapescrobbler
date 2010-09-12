require 'scrapescrobbler'
require 'spec_helper'

module Scrapescrobbler
  describe CLI do
    include HelperMethods

    describe "listen" do
      before :each do
        mockit
      end

      before do
        Station.create :name => "WYEP", :frequency => "91.3"
      end

      it "should complain without a station"

      it "should complain with more than one station"

      it "should start a last.fm session"

      it "should not return"

      it "should enable scrobbling for the station"
    end
  end
end
