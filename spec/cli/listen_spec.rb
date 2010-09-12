require 'scrapescrobbler'
require 'spec_helper'

module Scrapescrobbler
  describe CLI do
    include CLIHelperMethods

    describe "listen" do
      before :each do
        mock
      end

      before do
        Station.create :name => "WYEP", :frequency => "91.3"
      end

      it "should complain without a station" do
      end

      it "should complain with more than one station" do
      end

      it "should start a last.fm session" do
      end

      it "should not return" do
      end

      it "should enable scrobbling for the station" do
      end
    end
  end
end
