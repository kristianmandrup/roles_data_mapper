require 'sugar-high/module'

module Roles
  modules :data_mapper do
    nested_modules :user, :role
  end
  modules :base, :strategy
end   

module RoleStrategy
  modules :data_mapper
end