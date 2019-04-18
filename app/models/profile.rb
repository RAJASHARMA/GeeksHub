class Profile < ActiveRecord::Base
  include ProfilesHelper
  belongs_to :user
  has_one :image, :as => :imageable, dependent: :destroy

  validates_associated :image
  validates :name, persence: false, length: { in: 3..20 }, format: { with: /\A[a-zA-Z ]+\z/, message: "only allows letters" }, on: :update
  validates :public_email, persence: false, format: {with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "invalid email"}, on: :update
  validates :location, persence: false, format: { with: /\A[a-zA-Z ]*\z/, message: "only allows letters" }, on: :update
  validates :country, persence: false, format: { with: /\A[a-zA-Z ]*\z/, message: "only allows letters" }, on: :update
  validates :profession, persence: false, format: { with: /\A[a-zA-Z ]*\z/, message: "only allows letters" }, on: :update
  validates :organization, persence: false, format: { with: /\A[a-zA-Z0-9 ]*\z/, message: "only allows letters" }, on: :update

  extend FriendlyId
  friendly_id :id, use: :slugged
end
