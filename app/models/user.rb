class User < ActiveRecord::Base
  require 'uri'

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :image, :as => :imageable, dependent: :destroy
  has_one :profile, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,  :confirmable
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, on: :create
  validates :password, presence:true, length: {minimum: 8}, confirmation: true, on: :create
  
  enum role: [:admin, :moderator, :user]

  ratyrate_rater

  after_create :default_role, :create_profile

  private
  
  def default_role
    self.user!
  end

  def create_profile
    Profile.create(user: self)
  end

end
