class Helpers
  def self.logged_in?
    !!session[:user_id]
    # check if session[:user_id] == nil, return true if user is logged in, underwise, return false
    #if session[:user_id] == nil
    #  false
    #else
    #  true
    #end
  end

  def self.current_user
    User.find_by_id(session[:user_id])
  end
end
