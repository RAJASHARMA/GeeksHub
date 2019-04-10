class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :article

	
	validates :content, presence: true, length: { minimum: 2, maximum: 300 }

	resourcify
	has_ancestry
end
