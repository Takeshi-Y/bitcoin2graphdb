require 'rubygems'
require 'base'
require 'database_cleaner'
require 'bitcoin_mock'
require 'neo4j'

RSpec.configure do |config|

  DatabaseCleaner[:neo4j, connection: {type: :server_db, path: 'http://localhost:7475'}].strategy = :transaction
  include BitcoinMock

  config.before(:each) do |example|
    DatabaseCleaner.start
    setup_mock
    Graphdb.configuration.unload_extensions
  end

  config.after(:each) do |example|
    DatabaseCleaner.clean
  end

end

def fixture_file(relative_path)
  file = File.read(File.join(File.dirname(__FILE__), 'fixtures', relative_path))
  JSON.parse(file)
end