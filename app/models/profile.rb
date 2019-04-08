class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :image, :as => :imageable, dependent: :destroy

  validates :name, numericality: false, length: { in: 3..20 }, on: :update
  validates :public_email, format: { with: URI::MailTo::EMAIL_REGEXP, on: :update }
  validates :location, numericality: false
  validates :country, numericality: false
  validates :profession, numericality: false
  validates :organization, numericality: false

end
