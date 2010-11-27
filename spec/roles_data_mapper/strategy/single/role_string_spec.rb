require 'spec_helper'
use_roles_strategy :role_string

class User
  include DataMapper::Resource  
  include Roles::DataMapper 
  
  strategy :role_string, :default
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
  :role_string
end

load 'roles_data_mapper/strategy/api_examples.rb'

# require 'spec_helper'
# use_roles_strategy :role_string
# 
# class User 
#   include DataMapper::Resource  
#   include Roles::DataMapper 
#   
#   strategy :role_string, :default
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
# describe "Roles for DataMapper: :role_string strategy" do
#   require "roles_data_mapper/user_setup"
#   require "roles_generic/rspec/api"
# end
