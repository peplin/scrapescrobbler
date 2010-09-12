require 'scrapescrobbler'
require 'spec_helper'
require 'lastfm'

module Scrapescrobbler
  describe Listener do
    include HelperMethods

    describe "with an instance" do
      before :each do
        mockit
        @mock_lastfm = mock(::Lastfm)
        @station = Station.create :name => "WYEP", :frequency => "91.3"
        @listener = Listener.new :station => @station
      end

      it "should have a station" do
        @listener.station.should eq(@station)
      end

      it "should have a last.fm instance" do
        @listener.lastfm.should be_an_instance_of(::Lastfm)
      end

      describe "that is inactive" do
        it "should not have a start time" do
          @listener.started.should eq(nil)
        end

        it "should not have a last.fm session" do
          @listener.lastfm.should_not respond_to(:auth)
        end
      end

      describe "that is active" do
        before :each do
          @listener.listen
        end

        it "should have a start time" do
          @listener.should respond_to(:started)
          @listener.started.should be_an_instance_of(DateTime)
        end

        it "should have a last.fm session" do
          @listener.lastfm.should respond_to(:auth)
          @listener.lastfm.auth.should respond_to(:session)
        end

        it "should have a current song" do
          @listener.should respond_to(:now_playing)
          @listener.now_playing.should be_an_instance_of(Song)
        end

        describe "and when updated" do
          it "should check the station's playlist" do
            @listener.station.should_receive(:playlist)
          end

          describe "and there is a new song to scrobble" do
            before do
              @song = Song.new(:time => Time.now, :station => @station,
                  :title => "The Best Song Ever")
              Station.stub!(:playlist).and_return(@song)
            end

            it "should create a new Song" do
              proc { @listener.update }.should change(Song, :count).by(1)
              song = Song.first :time => @song.time, :station => @song.station
              song.title.should eq(@song.title)
            end
            
            it "should scrobble the song" do
              @mock_lastfm.should_receive(:scrobble).with(@song.artist,
                  @song.title, @song.album)
            end

            it "should have a current song that matches the new song" do
              @listener.now_playing.should eq(@song)
            end
          end

          describe "and there is not a new song to scrobble" do
            before do
              @song = Song.create(:time => Time.now, :station => @station,
                  :title => "The Best Song Ever")
              Station.stub!(:playlist).and_return(@song)
            end

            it "should not create a new Song" do
              proc { @listener.update }.should_not change(Song, :count).by(1)
            end

            it "should not scrobble the song" do
              @mock_lastfm.should_not_receive(:scrobble).with(@song.artist,
                  @song.title, @song.album)
            end

            it "should not update the current song" do
              proc { @listener.update }.should_not change(@listener, :now_playing)
            end
          end
        end
      end
    end
  end
end
