class <%= role_class %>
  include DataMapper::Resource
  
  def self.named role_names 
    where(:name.in => role_names.flatten)
  end

  property :id, Serial
  property :name, String

  validates_uniqueness_of :name

  has n, :<%= user_role_class.to_s.pluralize.underscore %>
  has n, :<%= user_class.to_s.pluralize.underscore %>, :through => :<%= user_role_class.to_s.pluralize.underscore %>

  extend RoleClass::ClassMethods
end  
