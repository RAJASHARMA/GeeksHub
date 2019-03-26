class Article < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_one :image, :as => :imageable, dependent: :destroy

	validates :title, presence: true, length: { in: 3..20 }, :uniqueness => {alert: "Already Exixts" }
	validates :content, presence: true 
	
	acts_as_taggable_on :tags
	ratyrate_rateable "content"
	resourcify
end
