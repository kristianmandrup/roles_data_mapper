require 'roles_data_mapper/strategy/single'

class Role
  def self.named role_names 
    where(:name.in => role_names.flatten)
  end

  # belongs_to :user, :required => false
  # has n, :users, :child_key => [ :one_role ]  
end

module RoleStrategy::DataMapper
  module OneRole
    def self.default_role_attribute
      :one_role
    end

    def self.included base
      base.extend Roles::Generic::Role::ClassMethods
      base.extend ClassMethods
      # base.instance_eval "has 1, :one_role, 'Role'" # , :parent_key => [role_id], :child_key => [:id]  
      base.instance_eval "belongs_to :one_role, :class_name => 'Role'" # :foreign_key => :role_id
    end

    module ClassMethods 
      # def role_attribute
      #   strategy_class.roles_attribute_name.to_sym
      # end       
         
      def in_role(role_name)                          
        role = Role.all(:name => role_name).first
        # puts "in role: #{role.inspect}, id: #{role.id}"
        all(:one_role_id => role.id)
      end

      def in_any_role(*roles)                          
        role_ids = Role.all(:name.in => roles.flatten).map{|role| role.id}
        all(:one_role_id => role_ids)
      end
    end

    module Implementation
      include Roles::DataMapper::Strategy::Single
      
      def new_role role
        role_class.find_role(extract_role role)
      end

      def new_roles *roles
        new_role roles.flatten.first
      end

      def remove_roles *role_names
        roles = role_names.flat_uniq
        set_empty_role if roles_diff(roles).empty?
        true
      end 

      def present_roles *roles
        roles.map{|role| extract_role role}
      end

      def set_empty_role
        self.send("#{role_attribute}=", nil)
      end
    end

    extend Roles::Generic::User::Configuration
    configure :num => :single, :type => :role_class    
  end  
end
