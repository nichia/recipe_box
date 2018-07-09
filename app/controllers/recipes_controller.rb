class RecipesController < ApplicationController

  # HTTP Verb - Route - Action - Used For

  # GET - /recipes - index action - index page to display all recipes
  get '/recipes' do
    if Helpers.logged_in?(session)
      @recipes = Recipe.all.sort_by do |recipe|
        recipe.name
      end

      erb :'/recipes/index'
    else
      flash[:message] = "You must be logged in to view recipes."
      redirect :"/login"
    end
  end

  # GET /recipes/new - new action - displays create recipe form
  get '/recipes/new' do
    if Helpers.logged_in?(session)
      @categories = Category.all.sort_by do |category|
        category.name
      end

      erb :'/recipes/new'
    else
      flash[:message] = "You must be logged in to add a recipe."
      redirect :"/login"
    end
  end

  # POST /recipes - create action - create a new recipe
  post '/recipes' do
    binding.pry

    if params[:recipe][:name].empty?
      flash[:message] = "Your recipe name cannot be left blank."
      redirect :"/recipes/new"
    else
      recipe = Recipe.create(params[:recipe])
      recipe.user_id = session[:user_id]

      # new category
      if !params[:category][:name].empty?
        if Category.find_by(name: params[:category][:name])
          flash[:message] = "Category already exists, please select from checklist."
        else
          recipe.categories << Category.create(name: params[:category][:name])
        end
      end


      recipe.save

      flash[:message] = "Successfully added your recipe."
      redirect :"/recipes/#{recipe.slug}"
    end
  end

  get '/recipes/:slug' do
    @recipe = Recipe.find_by_slug(params[:slug])

    erb :'/recipes/show'
  end

end
