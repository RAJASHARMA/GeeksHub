class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,  :confirmable
  has_many :articles
  has_many :comments
  validates :name, presence: true, numericality: false, length: { in: 3..20 }
  acts_as_tagger
end
