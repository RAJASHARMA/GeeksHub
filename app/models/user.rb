class User < ActiveRecord::Base
  
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,  :confirmable
  
  validates :name, presence: true, numericality: false, length: { in: 3..20 }

  rolify
  ratyrate_rater
  # acts_as_tagger

  after_create :default_role

  private
  def default_role
  	# byebug
  	self.add_role 'user'
  end
end
