class Category < ActiveRecord::Base
  has_many :recipe_categories
  has_many :recipes, through: :recipe_categories

  #extend Slugifiable::ClassMethods
  #include Slugifiable::InstanceMethods
  # Slugifiable does not work, yet it works for user and recipe: Could not require /Users/nichia/Development/code/sinatra-recipe-box/app/models/category.rb (uninitialized constant Category::Slugifiable). Please require the necessary files (RequireAll::LoadError)

end
