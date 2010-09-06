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

User.valid_roles_are :admin, :guest   

describe "Roles for Mongoid" do  
  
  context "default setup" do

    before :each do  
      @user = User.create(:name => 'Kristian')
      @user.role = :guest      
      @user.save     

      @admin_user = User.create(:name => 'Admin user')
      @admin_user.roles = :admin            
      @admin_user.save
    end
    
    describe '#in_role' do
      it "should return first user matching role" do        
        User.in_role(:guest).first.name.should == 'Kristian'      
        User.in_role(:admin).first.name.should == 'Admin user'
      end
    end

    describe "Role API" do
      it "should have admin user role to :admin" do      
        @admin_user.roles_list.first.should == :admin      
        @admin_user.admin?.should be_true
        
        @admin_user.has_role?(:guest).should be_false
        
        @admin_user.has_role?(:admin).should be_true
        @admin_user.is?(:admin).should be_true
        @admin_user.has_roles?(:admin).should be_true
        @admin_user.has?(:admin).should be_true      
      end
          
      it "should have user role to :guest" do
        @user.roles_list.first.should == :guest
        @user.admin?.should be_false
      
        @user.has_role?(:guest).should be_true    
        @user.has_role?(:admin).should be_false
        @user.is?(:admin).should be_false
      
        @user.has_roles?(:admin).should be_false
        @user.has?(:admin).should be_false
      end  
      
      it "should set user role to :admin using roles=" do
        @user.roles = :admin      
        @user.roles_list.first.should == :admin           
        @user.has_role?(:admin).should be_true      
      end  
    end  
  end
end

