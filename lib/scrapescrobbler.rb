require 'dm-core'
require 'dm-migrations'
require 'dm-validations'

require File.join(File.dirname(__FILE__), 'scrapescrobbler', 'config')
require File.join(File.dirname(__FILE__), 'scrapescrobbler', 'helpers')
require File.join(File.dirname(__FILE__), 'scrapescrobbler', 'cli')

DB_NAME = 'sqlite://' + (defined?(TEST_MODE) ? '/tmp/db' : Scrapescrobbler::Config['database_file'])
DataMapper::Logger.new($stdout, :debug) if defined?(TEST_MODE)
DataMapper.setup(:default, DB_NAME)

Dir["#{File.dirname(__FILE__)}/scrapescrobbler/models/*.rb"].each do |path|
  require path
end

DataMapper.finalize
DataMapper.auto_upgrade!
