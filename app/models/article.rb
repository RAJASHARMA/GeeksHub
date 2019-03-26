class Article < ActiveRecord::Base
	acts_as_taggable_on :tags
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :title, presence: true, length: { in: 3..20 }, :uniqueness => {alert: "Already Exixts" }
	validates :content, presence: true 
	resourcify
end
