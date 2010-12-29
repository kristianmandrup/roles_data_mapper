class <%= role_class %>
  include DataMapper::Resource
  
  def self.named role_names 
    where(:name.in => role_names.flatten)
  end

  property :id, Serial
  property :name, String

  validates_uniqueness_of :name

  extend RoleClass::ClassMethods
end  
