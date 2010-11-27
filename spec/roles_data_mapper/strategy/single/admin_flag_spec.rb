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

load 'roles_active_record/strategy/api_examples.rb'


# require 'spec_helper'
# use_roles_strategy :admin_flag
# 
# class User 
#   include DataMapper::Resource  
#   include Roles::DataMapper 
#   
#   strategy :admin_flag, :default
# 
#   property :id, Serial
#   property :name, String  
# end
# 
# DataMapper.finalize
# DataMapper.auto_migrate!
# 
# User.valid_roles_are :admin, :guest  
# 
# describe "Roles for DataMapper: :admin_flag strategy" do
#   require "roles_data_mapper/user_setup"
#   require "roles_generic/rspec/api"
# end
