module Roles::Base
  def valid_roles_are(*role_list)
    strategy_class.valid_roles = role_list.to_symbols
  end
end

module Roles
  module DataMapper  
    def self.included(base) 
      base.extend Roles::Base
      base.extend ClassMethods
      base.orm_name = :data_mapper
    end

    module ClassMethods
      
      MAP = {
        :admin_flag   => "property :admin_flag,   ::DataMapper::Property::Flag[:admin, :guest]",
        :roles_mask   => "property :roles_mask,   Integer, :default => 0",
        :role_string  => "property :role_string,  String",
        :roles_string => "property :roles_string, String"
      }
      
      def strategy name, options=nil
        if options == :default && MAP[name]
          instance_eval MAP[name] 
        end
        set_role_strategy name, options
      end    
    end
  end
end
