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

      def valid_single_strategies
        [:admin_flag, :one_role, :role_string]
      end

      def valid_multi_strategies
        [:many_roles, :roles_mask]
      end

      def valid_strategies
        valid_single_strategies + valid_multi_strategies
      end
      
      def strategy name, options={}
        strategy_name = name.to_sym
        raise ArgumentError, "Unknown role strategy #{strategy_name}" if !valid_strategies.include? strategy_name

        use_roles_strategy strategy_name

        set_role_class(strategy_name, options) if strategies_with_role_class.include? strategy_name
                
        if options == :default && MAP[name]
          instance_eval MAP[name] 
        end
        
        set_role_strategy name, options
      end 

      private

      def set_role_class strategy_name, options = {}
        @role_class_name = !options.kind_of?(Symbol) ? get_role_class(strategy_name, options) : default_role_class(strategy_name)
      end

      def default_options? options = {}
        return true if options == :default                           
        if options.kind_of? Hash
          return true # if options[:config] == :default || options == {} 
        end
        false
      end

      def statement code_str
        code_str.gsub /Role/, @role_class_name.to_s
      end

      def default_role_class strategy_name
        if defined? ::Role
          require "roles_data_mapper/role_class"
          return ::Role 
        end
        raise "Default Role class not defined"
      end

      def strategies_with_role_class
        # :embed_one_role, :embed_many_roles
        [:one_role, :many_roles]
      end 

      def get_role_class strategy_name, options
        options[:role_class] ? options[:role_class].to_s.camelize.constantize : default_role_class(strategy_name)
      end      
         
    end
  end
end
