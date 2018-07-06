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

end
