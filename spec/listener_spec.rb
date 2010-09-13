require 'scrapescrobbler'
require 'spec_helper'
require 'lastfm'

module Scrapescrobbler
  describe Listener do
    include HelperMethods

    describe "with an instance" do
      before :each do
        mockit
        ::Lastfm::MethodCategory::Auth.any_instance.stubs(
            :get_session).returns("A session")
        ::Lastfm::MethodCategory::Auth.any_instance.stubs(
            :get_token).returns("a token")
        @scrobble_stub = ::Lastfm::MethodCategory::Track.any_instance.stubs(
            :scrobble).returns("Good job!")
        @station = "wyep"
        @listener = Listener.new @station
        @song = Song.new(:time => Time.now, :station => @station,
            :title => "The Best Song Ever", :artist => 'Price')
      end

      it "should have a station" do
        @listener.station.should eq(Stations::Wyep)
      end

      it "should have a last.fm instance" do
        @listener.lastfm.should be_an_instance_of(::Lastfm)
      end

      describe "that is inactive" do
        it "should not have a start time" do
          @listener.started.should eq(nil)
        end

        it "should not have a last.fm session" do
          @listener.lastfm.auth.should_not respond_to(:session)
        end
      end

      describe "that is active" do
        before :each do
          @listener.listen
          Stations::Wyep.stubs(:playlist).returns([@song])
        end

        it "should have a start time" do
          @listener.should respond_to(:started)
          @listener.started.should be_an_instance_of(DateTime)
        end

        it "should have a last.fm session" do
          @listener.lastfm.should respond_to(:auth)
          @listener.lastfm.should respond_to(:session)
        end

        it "should have a current song" do
          @listener.should respond_to(:now_playing)
          @listener.now_playing.should be_an_instance_of(Song)
        end

        describe "and when updated" do
          it "should check the station's playlist" do
            @listener.station.expects(:playlist)
            @listener.update
          end

          describe "and there is a new song to scrobble" do

            it "should create a new Song" do
              proc { @listener.update }.should change(Song, :count)
              song = Song.first :time => @song.time, :station => @song.station
              song.title.should eq(@song.title)
            end
            
            it "should scrobble the song" do
              @scrobble_stub.expects(:scrobble).with(@song.artist, @song.title)
              @listener.update
            end

            it "should have a current song that matches the new song" do
              @listener.update
              @listener.now_playing.should eq(@song)
            end
          end

          describe "and there is not a new song to scrobble" do
            before do
              @song.save
            end

            it "should not create a new Song" do
              @listener.update
              proc { @listener.update }.should_not change(Song, :count)
            end

            it "should not scrobble the song" do
              @scrobble_stub.expects(:scrobble).with(@song.artist,
                  @song.title).never
              @listener.update
            end

            it "should not update the current song" do
              @listener.update
              proc { @listener.update }.should_not change(@listener,
                  :now_playing)
            end
          end
        end
      end
    end
  end
end
