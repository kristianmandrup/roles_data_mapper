require 'spec_helper'
use_roles_strategy :roles_mask

class User
  include DataMapper::Resource  
  include Roles::DataMapper 
  
  strategy :roles_mask, :default
  property :id, Serial
  property :name, String   
end

DataMapper.finalize
DataMapper.auto_migrate!

User.valid_roles_are :admin, :guest, :user

# def api_migrate
#   migrate('roles_mask')
# end

def api_name
  :roles_mask
end

load 'roles_data_mapper/strategy/api_examples.rb'


