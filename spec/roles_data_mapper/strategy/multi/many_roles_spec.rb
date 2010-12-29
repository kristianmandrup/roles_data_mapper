require 'spec_helper'

class User
  include DataMapper::Resource  
  include Roles::DataMapper 
  
  strategy :many_roles
  
  property :id, Serial
  property :name, String   
end

DataMapper.finalize
DataMapper.auto_migrate!

User.valid_roles_are :admin, :guest, :user

def api_name
  :many_roles
end

load 'roles_data_mapper/strategy/api_examples.rb'
