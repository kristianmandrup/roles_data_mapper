require 'rspec/core'
require 'dm-core'
require 'dm-types'
require 'dm-migrations'
require 'roles_data_mapper'

# gem install dm-core dm-sqlite-adapter 
# gem install dm-types dm-validations dm-timestamps dm-aggregates dm-adjust dm-is-list dm-is-tree dm-is-versioned dm-is-nested_set 
# gem install rails_datamapper dm-migrations dm-observer

DataMapper::Logger.new($stdout, :debug)                 
DataMapper.setup(:default, 'sqlite::memory:')

RSpec.configure do |config|
  config.mock_with :mocha
end
