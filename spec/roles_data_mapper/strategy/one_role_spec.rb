require 'spec_helper' 
use_roles_strategy :one_role

class User 
  include DataMapper::Resource  
  include Roles::DataMapper 
  
  strategy :one_role, :default
  role_class :role

  property :id, Serial
  property :name, String 
end

DataMapper.finalize
DataMapper.auto_migrate!

User.valid_roles_are :admin, :guest  

describe "Roles for DataMapper: :one_role strategy" do
  require "roles_data_mapper/user_setup"
  require "roles_generic/rspec/api"
end
