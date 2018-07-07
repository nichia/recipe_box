module Slugifiable

  module ClassMethods
    def find_by_slug(slug)
      self.all.find do |object|
        object.slug == slug
      end
    end
  end

  module InstanceMethods
    def slug
      # \W - any non-word character (word character is letter, number, underscore)
      # remove the following character !@#$%^&*?:;"'
      self.name.gsub(/[!@#$%^&*?:;"']/, '').gsub(/\W/, '-').downcase
    end
  end

end
