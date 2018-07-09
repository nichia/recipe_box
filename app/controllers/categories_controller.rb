class CategoriesController < ApplicationController

  # GET /users - renders an index for listing categories
  get '/categories' do
    if Helpers.logged_in?(session)
      @categories = Category.all.sort do |category|
        category.name
      end
      erb :'/categories/index'
    else
      erb :'/users/login'
    end
  end

  # GET /categories/new - new action - displays create category form
  get '/categories/new' do
    if Helpers.logged_in?(session)
      erb :'/categories/new'
    else
      flash[:message] = "You must be logged in to add a category."
      redirect :"/login"
    end
  end


  # POST - /categories - create action - creates one category
  post '/categories' do
    #binding.pry
    if !Category.find_by(name: params[:name])
      category = Category.create(params)
    end

    redirect :"/categories/#{category.id}"
  end

  # GET - /categories/:id - show action - displays one category based on id in the url
  get '/categories/:id' do
    if Helpers.logged_in?(session)
      @category = Category.find(params[:id])
      if @category
        erb :'/categories/show'
      else
        erb :'not_found'
      end
    else
      flash[:message] = "You must be logged in to view the category."
      redirect :"/login"
    end
  end

end
