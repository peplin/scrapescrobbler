require 'scrapescrobbler'

module Scrapescrobbler
  module HelperMethods
    def invoke command
      Scrapescrobbler::CLI.parse command
      Scrapescrobbler::CLI.invoke
    end

    def mockit
      $stdout = StringIO.new
      $stdin = StringIO.new
      DataMapper.auto_migrate!
    end
  end
end
