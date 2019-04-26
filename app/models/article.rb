class Article < ActiveRecord::Base
  belongs_to :user, -> { includes(:profile) }
  has_many :comments, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_one :image, :as => :imageable, dependent: :destroy

  validates_associated :image
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

  def self.search(keyword)
    articles = Article.approved.tagged_with(keyword)
              .includes([user: [profile: :image]], :image)
    if articles.empty?
      articles = Article.approved.where("title LIKE ? ", "%#{keyword}%")
              .includes([user: [profile: :image]], :image)
    end
    articles
  end
end
