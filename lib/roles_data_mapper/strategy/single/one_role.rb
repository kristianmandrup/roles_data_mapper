class Role
  def self.named role_names 
    where(:name.in => role_names.flatten)
  end

  belongs_to :user, :required => false
end

module RoleStrategy::DataMapper
  module OneRole
    def self.default_role_attribute
      :one_role
    end

    def self.included base
      base.extend Roles::Generic::Role::ClassMethods
      base.extend ClassMethods
      base.instance_eval "has 1, :one_role, 'Role'" # , :parent_key => [role_id], :child_key => [:id]
    end

    module ClassMethods 
      def role_attribute
        strategy_class.roles_attribute_name.to_sym
      end       
         
      def in_role(role_name)                          
        role = Role.all(:name => role_name).first
        all('one_role.id' => role.id)
      end

      def in_roles(*roles)                          
        role_ids = Role.all(:name.in => roles.flatten).map{|role| role.id}
        all(:'one_role.id'.in => role_ids)
      end
    end

    module Implementation      
      # assign roles
      def roles=(*roles)      
        raise "Role class #{role_class} does not have a #find_role(role) method" if !role_class.respond_to? :find_role
        first_role = roles.flatten.first
        role_relation = role_class.find_role(first_role)  
        self.send("#{role_attribute}=", role_relation)
        save
      end
      alias_method :role=, :roles=
      
      # query assigned roles
      def roles
        role = self.send(role_attribute).name.to_sym
        [role]
      end
      
      def roles_list
        self.roles.to_a
      end      
    end

    extend Roles::Generic::User::Configuration
    configure :num => :single, :type => :role_class    
  end  
end
