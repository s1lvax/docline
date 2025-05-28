class Holiday < ApplicationRecord
  belongs_to :practitioner_profile
  validates :start_date, :end_date, presence: true
end
