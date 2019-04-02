class User < ActiveRecord::Base
  # require 'uri'

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :image, :as => :imageable, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,  :confirmable
  
  validates :name, presence: true, numericality: false, length: { in: 3..20 }, on: :create
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, on: :create
  validates :password, presence:true, length: {minimum: 8}, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  
  validates :name, numericality: false, length: { in: 3..20 }, on: :update
  # validates :public_email, format: { with: URI::MailTo::EMAIL_REGEXP, on: :update }
  # validates :password, length: { minimum: 8}, on: :update
  # validates :password_confirmation, confirmation: true, on: :update

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
