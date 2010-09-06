require 'sugar-high/file'
require 'sugar-high/array'

module Roles::Strategy
  class << self    
    def role_dir
      File.dirname(__FILE__)
    end    

    def gem_name
      :roles_data_mapper
    end    
  end
end           

