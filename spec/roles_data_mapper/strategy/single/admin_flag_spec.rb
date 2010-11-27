require 'spec_helper'
use_roles_strategy :admin_flag

class User
  include DataMapper::Resource  
  include Roles::DataMapper 
  
  strategy :admin_flag, :default
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
  :admin_flag
end

load 'roles_data_mapper/strategy/api_examples.rb'
