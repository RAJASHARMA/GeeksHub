class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :commentable, polymorphic: true
	has_many :comments, :as => :commentable, dependent: :destroy
	
	validates :content, presence: true, length: { minimum: 2, maximum: 300 }

	resourcify
end
