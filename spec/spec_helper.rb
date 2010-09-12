require 'scrapescrobbler'

module Scrapescrobbler
  module CLIHelperMethods
    def invoke command
      Scrapescrobbler::CLI.parse command
      Scrapescrobbler::CLI.invoke
    end

    def mock
      $stdout = StringIO.new
      $stdin = StringIO.new
      DataMapper.auto_migrate!
    end
  end
end
