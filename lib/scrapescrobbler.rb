require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'Getopt/Declare'

require File.join(File.dirname(__FILE__), 'scrapescrobbler', 'config')
require File.join(File.dirname(__FILE__), 'scrapescrobbler', 'helpers')
require File.join(File.dirname(__FILE__), 'scrapescrobbler', 'cli')
require File.join(File.dirname(__FILE__), 'scrapescrobbler', 'listener')

DB_NAME = 'sqlite://' + (defined?(TEST_MODE) ? '/tmp/db' : Scrapescrobbler::Config['database_file'])
DataMapper::Logger.new($stdout, :debug) if defined?(TEST_MODE)
DataMapper.setup(:default, DB_NAME)

Dir["#{File.dirname(__FILE__)}/scrapescrobbler/models/*.rb"].each do |path|
  require path
end

Dir["#{File.dirname(__FILE__)}/scrapescrobbler/stations/*.rb"].each do |path|
  require path
end

DataMapper.finalize
DataMapper.auto_upgrade!

module Scrapescrobbler
  extend self

  class AlreadyRunning < StandardError
    def message
      "Scrapescrobbler is already running"
    end
  end

  CLI.args = Getopt::Declare.new(<<-EOF)
    #{CLI::USAGE}
  EOF
end
