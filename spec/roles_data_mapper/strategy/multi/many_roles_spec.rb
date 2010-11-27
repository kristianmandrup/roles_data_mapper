require 'spec_helper'
use_roles_strategy :many_roles

class User
  include DataMapper::Resource  
  include Roles::DataMapper 
  
  strategy :many_roles, :default
  role_class :role
  
  property :id, Serial
  property :name, String   
end

DataMapper.finalize
DataMapper.auto_migrate!

User.valid_roles_are :admin, :guest, :user

# def api_migrate
#   migrate('many_roles')
# end
# 
# def api_fixture
#   load 'fixtures/many_roles_setup.rb'
# end

def api_name
  :many_roles
end

load 'roles_data_mapper/strategy/api_examples.rb'
