module RoleStrategy::DataMapper
  module AdminFlag    
    def self.default_role_attribute
      :admin_flag
    end

    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods 
      def role_attribute
        strategy_class.roles_attribute_name.to_sym
      end
           
      def in_role(role_name) 
        case role_name.downcase.to_sym
        when :admin
          all(role_attribute => :admin)
        else
          all(role_attribute => :default)
        end          
      end
    end

    module Implementation
      include Roles::DataMapper::Strategy::Single

      def new_role role
        role = role.kind_of?(Array) ? role.flatten.first : role
        role.admin?
      end
      
      def get_role
        self.send(role_attribute) ? strategy_class.admin_role_key : strategy_class.default_role_key
      end 
      
      def present_roles *roles
        roles = roles.flat_uniq
        roles.map{|role| role ? :admin : :guest}
      end   
      
      def set_empty_role
        self.send("#{role_attribute}=", false)
      end      
    end # Implementation
    # 
    # module Implementation
    #   def role_attribute
    #     strategy_class.roles_attribute_name
    #   end
    #       
    #   # assign roles
    #   def roles=(*new_roles)                                 
    #     first_role = new_roles.flatten.first
    #     if valid_role?(first_role)        
    #       value = first_role.admin? ? :admin : :default
    #       self.send("#{role_attribute}=", value) 
    #     else
    #       raise ArgumentError, "The role #{first_role} is not a valid role"
    #     end
    #   end
    # 
    #   # query assigned roles
    #   def roles        
    #     role = self.send(role_attribute).include?(:admin) ? strategy_class.admin_role_key : strategy_class.default_role_key
    #     [role]
    #   end
    #   alias_method :roles_list, :roles
    # 
    # end # Implementation 
    
    extend Roles::Generic::User::Configuration
    configure :num => :single
  end   
end
