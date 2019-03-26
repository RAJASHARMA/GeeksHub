class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_one :image, :as => :imageable, dependent: :destroy
	acts_as_taggable_on :tags 
end
