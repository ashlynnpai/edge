def set_current_user
  user = Fabricate(:user)
  session[:user_id] = user.id
end

def set_admin(admin=nil) 
  session[:user_id] = (admin || Fabricate(:admin).id)
end