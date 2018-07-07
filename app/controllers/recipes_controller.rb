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
      erb :'/recipes/new'
    else
      flash[:message] = "You must be logged in to add a recipe."
      redirect :"/login"
    end
  end

end
