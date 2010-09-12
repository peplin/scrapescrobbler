require 'scrapescrobbler'

module Scrapescrobbler
  describe CLI do
    before :each do
      $stdout = StringIO.new
      $stdin = StringIO.new
      DataMapper.auto_migrate!
    end

    describe "list" do
      def invoke command
        Scrapescrobbler::CLI.parse command
        Scrapescrobbler::CLI.invoke
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
