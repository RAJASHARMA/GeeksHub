class Article < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_one :image, :as => :imageable, dependent: :destroy

	validates :title, presence: true, length: { in: 3..40 }, uniqueness: { case_sensitive: false }
	validates :content, presence: true 

	enum status: [:pending, :moderator_approved, :approved, :declined]
	
	acts_as_taggable
	ratyrate_rateable "content"

	after_create :default_status

	extend FriendlyId
  	friendly_id :title, use: :slugged

	private
	
	def default_status
		self.pending!
	end
end
