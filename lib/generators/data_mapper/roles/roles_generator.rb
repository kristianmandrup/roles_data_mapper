require 'rails3_artifactor'
require 'logging_assist'

module DataMapper 
  module Generators
    class RolesGenerator < Rails::Generators::Base      
      desc "Add role strategy User model using Data Mapper" 
      
      argument     :user_class,       :type => :string,   :default => 'User',                         :desc => "User class name"
      
      class_option :strategy,         :type => :string,   :aliases => "-s",   :default => 'role_string', 
                   :desc => "Role strategy to use (admin_flag, role_string, roles_string, role_strings, one_role, many_roles, roles_mask)"



      class_option :roles,            :type => :array,    :aliases => "-r",   :default => [],         :desc => "Valid roles"
      
      class_option :role_class,       :type => :string,   :aliases => "-rc",  :default => 'Role',     :desc => "Role class name"
      class_option :user_role_class,  :type => :string,   :aliases => "-urc", :default => 'UserRole', :desc => "User-Role (join table) class name"

      class_option :logfile,          :type => :string,   :aliases => "-l",   :default => nil,        :desc => "Logfile location"

      def apply_role_strategy
        logger.add_logfile :logfile => logfile if logfile
        logger.debug "apply_role_strategy for : #{strategy} in model #{user_class}"

        if !valid_strategy?
          say "Strategy '#{strategy}' is not valid, at least not for Data Mapper", :red
          return 
        end

        if !has_model_file?(user_class)
          say "User model #{user_class} not found", :red
          return 
        end
       
        begin
          insert_into_model user_class, :after => 'include DataMapper::Resource'  do
            insertion_text
          end
        rescue Exeption => e
          logger.debug"Error: #{e.message}"
        end 
        
        copy_role_models if role_class_strategy?        
     end 
                 
      protected                  

      extend Rails3::Assist::UseMacro
      include Rails3::Assist::BasicLogger

      use_orm :data_mapper

      def valid_strategy?
        valid_strategies.include? strategy.to_sym
      end

      def valid_strategies
        [:admin_flag, :role_string, :one_role, :many_roles, :roles_mask]
      end        

      def copy_role_models
        logger.debug 'copy_role_models'
        case strategy.to_sym  
        when :one_role
          copy_one_role_model
        when :many_roles
          copy_many_roles_models
        end
      end

      def copy_one_role_model
        logger.debug "copy_one_role_model: #{role_class.underscore}"

        template 'one_role/role.rb', "app/models/#{role_class.underscore}.rb"
      end

      def copy_many_roles_models        
        logger.debug "copy_many_roles_models: #{role_class.underscore} and #{user_role_class.underscore}"

        template 'many_roles/role.rb', "app/models/#{role_class.underscore}.rb"        
        template 'many_roles/user_role.rb', "app/models/#{user_role_class.underscore}.rb"
      end

      def logfile
        options[:logfile]
      end

      def orm
        :data_mapper
      end
  
      def default_roles
        [:admin, :guest]        
      end

      def role_class_strategy?
        [:one_role, :many_roles].include? strategy.to_sym
      end
  
      def roles_to_add
        @roles_to_add ||= default_roles.concat(options[:roles]).to_symbols.uniq
      end
  
      def roles        
        roles_to_add.map{|r| ":#{r}" }
      end
  
      def role_strategy_statement 
        "strategy :#{strategy} #{strategy_options}"
      end

      def strategy_options
        return ", :role_class => :#{role_class.to_s.underscore}" if role_class_strategy? && role_class.to_s != 'Role'
        ''
      end
        
      def valid_roles_statement
        return '' if has_valid_roles_statement?
        roles ? "valid_roles_are #{roles.join(', ')}" : ''
      end

      def has_valid_roles_statement? 
        !(read_model(user_class) =~ /valid_roles_are/).nil?
      end
  
      def insertion_text
        %Q{include Roles::#{orm.to_s.camelize} 
  #{role_strategy_statement}
  #{valid_roles_statement}}
      end

      def user_class
        options[:user_class].classify || 'User'
      end

      def role_class
        options[:role_class].classify || 'Role'
      end

      def user_role_class
        options[:user_role_class].classify || 'UserRole'
      end
        
      def strategy
        options[:strategy]                
      end
    end
  end
end