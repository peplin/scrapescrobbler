require 'scrapescrobbler'

module Scrapescrobbler
  describe Song do
    before do
      @song = Song.new
    end

    it "should have a time" do
      @song.should respond_to :time
    end

    it "should have an artist" do
      @song.should respond_to :artist
    end

    it "should have a title" do
      @song.should respond_to :title
    end

    it "should have a station" do
      @song.should respond_to :station
    end

    it "shouldn't save without a station" do
      @song.save.should == false
    end

    it "should require a station" do
      @song.station_id = 1
      @song.save.should == true
    end
  end
end
