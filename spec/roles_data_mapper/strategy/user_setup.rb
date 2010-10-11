def default_user_setup
  @guest_user = User.create(:name => 'Guest User')
  @guest_user.add_roles :guest      
  @guest_user.save     

  @normal_user = User.create(:name => 'Normal User')
  @normal_user.roles = :guest, :user      
  @normal_user.save     

  @admin_user = User.create(:name => 'Admin user')
  @admin_user.roles = :admin            
  @admin_user.save
end
