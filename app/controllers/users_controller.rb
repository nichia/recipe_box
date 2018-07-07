class UsersController < ApplicationController

  # GET /users - renders an index for listing users
  get '/users' do
    if Helpers.logged_in?(session)
      @users = User.all.sort_by do |user|
        user.name
      end

      erb :'/users/index'
    else
      erb :'/users/login'
    end
  end

  # GET /login - renders a form for logging in
  get '/login' do
    if Helpers.logged_in?(session)
      redirect :"/recipes"
    else
      erb :'/users/login'
    end
  end

  # POST /login - find the user by username and check that the password matches up. Fill in the session data
  post '/login' do
    if params[:name].empty? || params[:password].empty?
      flash[:message] = "Username and password cannot be left blank."
      erb :'/users/login'
    else
      user = User.find_by(name: params[:name])
      if user && user.authenticate(params[:password])
        flash[:message] = "You've successfully created an account with Recipe Box."
        session[:user_id] = user.id
        redirect :"/recipes"
      else
        session.clear
        flash[:message] = "Username not found, please try again."
        erb :'/users/login'
      end
    end
  end

  # GET /signup - renders a form to signup a new user. The form includes fields for username, email and password
  get '/signup' do
    if Helpers.logged_in?(session)
      redirect :"/recipes"
    else
      erb :'/users/signup'
    end
  end

  # POST /signup - create a new instance of user class with a username, email and password. Fill in the session data
  post '/signup' do
    if params[:name].empty? || params[:email].empty? || params[:password].empty?
      flash[:message] = "Username, email and password can not be left blank."
      redirect :"/signup"
    elsif User.find_by(name: params[:name])
      flash[:message] = "Username already taken, please use another username."
      redirect :"/signup"
    elsif User.find_by(email: params[:email])
      flash[:message] = "An account already exists with this email, please use another email."
      redirect :"/signup"
    else
      user = User.new
      user.name = params[:name]
      user.email = params[:email]
      user.password = params[:password]
      user.save

      session[:user_id] = user.id
      redirect :"/recipes"
    end
  end

  # GET /logout - clears the session data and redirects to the homepage
  get '/logout' do
    if Helpers.logged_in?(session)
      session.clear
      flash[:message] = "Successfully logged out."
      redirect :"/login"
    else
      redirect :"/"
    end
  end

  # GET /users/:slug - Read action to list this user's recipes
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user
      erb :'/users/show'
    else
      erb :'not_found'
    end
  end

end
