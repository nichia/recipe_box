require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }

    enable :sessions
    use Rack::Flash
    set :session_secret, "recipe password_security"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
      # check if session[:user_id] == nil, return true if user is logged in, underwise, return false
      #if session[:user_id] == nil
      #  false
      #else
      #  true
      #end
    end

    def current_user
      User.find(session[:user_id])
    end

    def login(username, password)
      user = User.find_by(:username => username)
      if user && user.authenticate(password)
        session[:user_id] = user.id
        session[:username] = user.username
      else
        session.clear
      end
    end
  end

end
