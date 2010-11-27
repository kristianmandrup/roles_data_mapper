require 'roles_data_mapper/strategy/single'

module RoleStrategy::DataMapper
  module RoleString    
    def self.default_role_attribute
      :role_string
    end

    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods
      def role_attribute
        strategy_class.roles_attribute_name.to_sym
      end 

      def in_role role_name
        all(:role_string => role_name)
      end
    end

    module Implementation 
      include Roles::DataMapper::Strategy::Single

      def new_role role
        role = role.kind_of?(Array) ? role.first : role
        role.to_s
      end

      def new_roles *roles
        new_role roles.flatten.first
      end
      
      def present_role role
        return role if role.kind_of? Array
        role.split(',').map(&:to_sym)
      end

      def set_empty_role
        self.send("#{role_attribute}=", "")
      end

      alias_method :present_roles, :present_role
    end
    
    # module Implementation 
    #   def role_attribute
    #     strategy_class.roles_attribute_name
    #   end 
    #               
    #   # assign roles
    #   def roles=(*roles)
    #     self.role = roles.select_labels.first.to_s
    #   end 
    #   
    #   def role= role_name
    #     if role_name.kind_of_label? && valid_role?(role_name)
    #       self.send("#{role_attribute}=", role_name.to_s) 
    #     end        
    #   end
    # 
    #   # query assigned roles
    #   def roles
    #     role = self.send(role_attribute)
    #     [role.to_sym]
    #   end
    #   alias_method :roles_list, :roles
    # end

    extend Roles::Generic::User::Configuration
    configure :num => :single
  end
end


