class RecipesController < ApplicationController

  # HTTP Verb - Route - Action - Used For

  # GET /recipes - index action - index page to display all recipes
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
    #binding.pry

    if params[:recipe][:name].empty?
      flash[:message] = "Your recipe name cannot be left blank."
      redirect :"/recipes/new"
    elsif (recipe = find_by_name(params[:recipe][:name])
      flash[:message] = "A recipe already exists with this name, please use another recipe name."
      redirect :"/recipes/new"
    else
      recipe = Recipe.create(params[:recipe])
      recipe.user_id = session[:user_id]
      recipe.save

      # new category
      if !params[:category][:name].empty?
        if Category.find_by(name: params[:category][:name])
          flash[:message] = "Category already exists, please select from checklist."
        else
          recipe.categories << Category.create(name: params[:category][:name])
        end
      end

      # new ingredients
      if !params[:ingredients].empty?
        params[:ingredients].each do |data|
          if !data[:name].empty?
            ingredient= Ingredient.new(data)
            ingredient.recipe = recipe
            ingredient.save
          end
        end
      end

      # new instructions
      if !params[:instructions].empty?
        params[:instructions].each do |data|
          if !data[:content].empty?
            instruction = Instruction.new(data)
            instruction.recipe = recipe
            instruction.save
          end
        end
      end
      #binding.pry

      flash[:message] = "Successfully added your recipe."
      redirect :"/recipes/#{recipe.slug}"
    end
  end

  # GET /recipes/:slug - Read action to list the recipe based on :slug in the url
  get '/recipes/:slug' do
    @recipe = Recipe.find_by_slug(params[:slug])
    if @recipe
      erb :'/recipes/show'
    else
      erb :'not_found'
    end
  end

  # GET - /recipes/:slug/edit - edit action - displays one recipe based on recipe slug in the url for editing
  get '/recipes/:slug/edit' do
    if Helpers.logged_in?(session)
      @recipe = Recipe.find_by_slug(params[:slug])
      if @recipe && Helpers.current_user(session).id == @recipe.user_id
        @categories = Category.all.sort_by do |category|
          category.name
        end
        erb :'/recipes/edit'
      else
        flash[:message] = "You must be the recipe owner to edit a recipe."
        redirect :"/recipes/#{recipe.slug}"
      end
    else
      flash[:message] = "You must be logged in to edit a recipe."
      redirect :"/login"
    end
  end

  # PATCH - /recipes/:slug - edit action - edits an existing recipe based on recipe slug in the url
  patch '/recipes/:slug' do
    #binding.pry
    recipe = Recipe.find_by_slug(params[:slug])

    if params[:recipe][:name].empty?
      flash[:message] = "Your recipe name cannot be left blank! "
      redirect :"/recipes/#{recipe.slug}/edit"
    else
      recipe.update(params[:recipe])

      # new category
      if !params[:category][:name].empty?
        if Category.find_by(name: params[:category][:name])
          flash[:message] = "Category already exists, please select from checklist."
        else
          recipe.categories << Category.create(name: params[:category][:name])
        end
      end

      # ingredients
      if !params[:ingredients].empty?
        params[:ingredients].each do |data|
          if data[:id].empty?
            # add new line of ingredient record (no ingredient.id)
            if !data[:info][:name].empty?
              ingredient= Ingredient.new(data[:info])
              ingredient.recipe = recipe
              ingredient.save
            end
          elsif data[:info].empty?
            # delete existing ingredient record
            ingredient = Ingredient.find(data[:id])
            ingredient.destroy
          else
            # update existing ingredient record
            ingredient = Ingredient.find(data[:id])
            ingredient.update(data[:info])
          end
        end
      end

      # instructions
      if !params[:instructions].empty?
        params[:instructions].each do |data|
          if data[:id].empty?
          # add new line of instruction record
            if !data[:content].empty?
              instruction = Instruction.new(content: data[:content])
              instruction.recipe = recipe
              instruction.save
            end
          elsif data[:content].empty?
            # delete existing instruction record
            instruction = Instruction.find(data[:id])
            instruction.destroy
          else
            # update existing instruction record
            instruction = Instruction.find(data[:id])
            instruction.update(content: data[:content])
          end
        end
      end

      #binding.pry
      flash[:message] = "Successfully edited Recipe!"
      redirect :"/recipes/#{recipe.slug}"
    end
  end

  # DELETE - /recipes/:slug/delete - delete action
  delete '/recipes/:id/delete' do
    if Helpers.logged_in?(session)
      @recipe = Recipe.find(params[:slug])
      if @recipe && Helpers.current_user(session).id == @recipe.user_id
        @recipe.delete
        flash[:message] = "You've successfully deleted your recipe #{params[:slug]}!"
        redirect :"/recipes"
      else
        flash[:message] = "You must be the recipe owner to delete a recipe."
        redirect :"/recipes/#{recipe.slug}"
      end
    else
        flash[:message] = "You must be logged in to delete a recipe."
        redirect :"/users/login"
    end
  end
end
