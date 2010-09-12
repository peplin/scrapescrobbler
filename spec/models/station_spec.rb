require 'scrapescrobbler'

module Scrapescrobbler
  describe Station do
    before do
      @station = Station.new
    end

    it "should have a frequency" do
      @station.should respond_to :frequency
    end

    it "should have an frequency" do
      @station.should respond_to :frequency
    end

    it "should have a name" do
      @station.should respond_to :name
    end

    it "should be fm by default" do
      @station.should respond_to :fm
      @station.fm.should == true
    end

    it "should have many songs" do
      @station.should respond_to :songs
    end
  end
end
