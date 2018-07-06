require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }

    enable :sessions
    use Rack::Flash
    set :session_secret, "recipe password_security"
  end

 # GET / - renders an index.erb file with links to signup or login or tweets action
  get '/' do
    erb :index
  end

end
