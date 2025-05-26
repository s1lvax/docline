class PractitionerProfile < ApplicationRecord
  belongs_to :user
  has_rich_text :bio

  has_one_attached :profile_picture

  validates :bio, length: { maximum: 1000 }
  validates :profession, length: { maximum: 255 }
end
