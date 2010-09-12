require 'dm-core'
require 'dm-migrations'
require 'dm-validations'

require File.join(File.dirname(__FILE__), 'scrapscrobbler', 'config')
require File.join(File.dirname(__FILE__), 'scrapscrobbler', 'helpers')
require File.join(File.dirname(__FILE__), 'scrapscrobbler', 'cli')
Dir["#{File.dirname(__FILE__)}/scrapscrobbler/formatters/*.rb"].each do |path|
  require path
end

DB_NAME = defined?(TEST_MODE) ? 'sqlite:///tmp/db' : Scrapescrobbler::Config['database_file']
DataMapper::Logger.new($stdout, :debug) if defined?(TEST_MODE)
DataMapper.setup(:default, DB_NAME)

Dir["#{File.dirname(__FILE__)}/scrapscrobbler/models/*.rb"].each do |path|
  require path
end

DataMapper.finalize
DataMapper.auto_upgrade!
