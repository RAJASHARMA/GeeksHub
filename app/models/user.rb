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
  
  rolify
  ratyrate_rater

  after_create :default_role

  def self.rank_up(user,role)
    if current_user.has_role?(:admin)
      if user.has_role?(:user)
        user.add_role(:moderator)
      end
    end
  end

  private
  def default_role
    self.add_role ('user')
  end

end
