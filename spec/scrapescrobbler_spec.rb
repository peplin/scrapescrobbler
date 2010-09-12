require 'scrapescrobbler'

module Scrapescrobbler
  describe Scrapescrobbler do
    before :each do
      $stdout = StringIO.new
      $stdin = StringIO.new
    end

    describe 'CLI' do
      describe "commands" do
        def invoke command
          Scrapescrobbler::CLI.parse command
          Scrapescrobbler::CLI.invoke
        end

        describe 'stations' do
          it "should list all available stations" do
            invoke 'stations'
          end
        end

        describe "backend" do
          it "should open an sqlite console to the db" do
            Scrapescrobbler::CLI.should_receive(:exec).with("sqlite3 #{DB_NAME}")
            invoke 'backend'
          end
        end
      end
    end
  end
end
