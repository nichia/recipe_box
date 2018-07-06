class User < ActiveRecord::Base
  has_many :recipes, dependent: :destroy
  has_many :notes, dependent: :destroy

  has_secure_password

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
