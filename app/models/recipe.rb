class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  has_many :instructions, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :recipe_categories, dependent: :destroy
  has_many :categories, through: :recipe_categories

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

end
