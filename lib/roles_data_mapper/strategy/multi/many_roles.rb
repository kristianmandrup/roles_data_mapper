require 'roles_data_mapper/strategy/multi'

class Role
  def self.named role_names 
    where(:name.in => role_names.flatten)
  end

  property :id, Serial
  has n, :user_roles      
  has n, :users, :through => :user_roles
end  

class UserRole      
  include DataMapper::Resource
    
  belongs_to :user, 'User', :key => true
  belongs_to :role, 'Role', :key => true
end  


module RoleStrategy::DataMapper
  module ManyRoles
    def self.default_role_attribute
      :many_roles
    end

    def self.included base
      base.extend Roles::Generic::Role::ClassMethods
      base.extend ClassMethods
      base.instance_eval %{ 
        has n, :user_roles
        has n, :many_roles, 'Role', :through => :user_roles, :via => :role
      }      
    end

    module ClassMethods  
      def role_attribute
        strategy_class.roles_attribute_name
      end       
        
      def in_role(role_name)
        role = Role.all(:name => role_name).first
        all("user_roles.role_id" => role.id)
      end

      def in_any_role(*roles)                          
        role_ids = Role.all(:name.in => roles.flatten).map{|role| role.id}
        all("user_roles.role_id" => role_ids)
      end
    end
    
    module Implementation 
      include Roles::DataMapper::Strategy::Multi

      # assign multiple roles
      def roles=(*role_names)
        role_names = role_names.flat_uniq
        role_names = extract_roles(role_names)
        return nil if role_names.empty?
        valids = role_class.find_roles(role_names).to_a
        vrs = select_valid_roles role_names
        set_roles(vrs)
      end

      def new_roles *role_names
        role_class.find_roles(extract_roles role_names)
      end

      def present_roles roles_names
        roles_names.to_a.map{|role| role.name.to_s.to_sym}
      end

      def set_empty_roles
        self.send("#{role_attribute}=", [])
      end
      #       
      # def role_attribute
      #   strategy_class.roles_attribute_name
      # end 
      # 
      # # assign roles
      # def roles=(*_roles)  
      #   _roles = get_roles(_roles)
      #   return nil if roles.none?                
      #   
      #   role_relations = role_class.find_roles(_roles) 
      #   self.send("#{role_attribute}=", role_relations)
      #   self.save
      # end
      # 
      # def add_roles(*roles)  
      #   raise "Role class #{role_class} does not have a #find_role(role) method" if !role_class.respond_to? :find_role
      #   role_relations = role_class.find_roles(*roles)
      #   role_relations.each do |rel|
      #     self.send(role_attribute) << rel
      #   end
      # end
      # 
      # # query assigned roles
      # def roles
      #   self.send(role_attribute)
      # end
      # 
      # def roles_list     
      #   [roles].flatten.map{|r| r.name }.compact.to_symbols
      # end
    end 
    
    extend Roles::Generic::User::Configuration
    configure :type => :role_class    
  end
end

