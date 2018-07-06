class User < ActiveRecord::Base
  has_many :recipes, dependent: :destroy
  has_many :notes, dependent: :destroy
end
