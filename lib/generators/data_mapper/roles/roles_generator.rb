require 'rails3_artifactor'
require 'logging_assist'

module DataMapper 
  module Generators
    class RolesGenerator < Rails::Generators::NamedBase      
      desc "Add role strategy to a model" 
      
      # argument name
      
      class_option :strategy, :type => :string, :aliases => "-s", :default => 'role_string', 
                   :desc => "Role strategy to use (admin_flag, role_string, roles_string, role_strings, one_role, many_roles, roles_mask)"


      class_option :logfile, :type => :string,   :default => nil,   :desc => "Logfile location"
      class_option :roles, :type => :array, :default => [], :desc => "Valid roles"
      class_option :role_class,   :type => :string,   :aliases => "-rc", :default => 'Role', :desc => "Role class"

      def apply_role_strategy
        logger.add_logfile :logfile => logfile if logfile
        logger.debug "apply_role_strategy for : #{strategy} in model #{name}"

        if !has_model_file?(user_model_name)
          say "User model #{user_model_name} not found", :red
          return 
        end
       
        begin
          insert_into_model name, :after => 'include DataMapper::Resource'  do
            insertion_text
          end
        rescue Exeption => e
          logger.debug"Error: #{e.message}"
        end 
        
        copy_role_class if role_class_strategy?
     end 
      
      protected                  

      extend Rails3::Assist::UseMacro
      include Rails3::Assist::BasicLogger

      use_orm :data_mapper

      def copy_role_class
        logger.debug "copy_role_class: #{role_class.underscore}"
        template 'role.rb', "app/models/#{role_class.underscore}.rb"
      end

      def logfile
        options[:logfile]
      end

      def user_model_name
        name || 'User'
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
        !(read_model(user_model_name) =~ /valid_roles_are/).nil?
      end
  
      def insertion_text
        %Q{include Roles::#{orm.to_s.camelize} 
  #{role_strategy_statement}
  #{valid_roles_statement}}
      end

      def role_class
        options[:role_class].classify || 'Role'
      end
  
      def strategy
        options[:strategy]                
      end
    end
  end
end