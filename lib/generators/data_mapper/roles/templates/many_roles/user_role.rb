class <%= user_role_class %>      
  include DataMapper::Resource
    
  belongs_to :<%= user_class.underscore %>, '<%= user_class %>', :key => true
  belongs_to :<%= role_class.underscore %>, '<%= role_class %>', :key => true
end  
