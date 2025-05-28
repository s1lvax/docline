# app/models/slot.rb
class Slot < ApplicationRecord
  belongs_to :practitioner_availability
  belongs_to :practitioner_profile
  belongs_to :user, optional: true # Optional: only set when booked

  # Validations
  validates :start_time, :end_time, :practitioner_availability, :practitioner_profile, presence: true
  validate  :end_time_after_start_time

  # A slot is "booked" if user_id is present
  def booked?
    user_id.present?
  end

  private

  def end_time_after_start_time
    return if start_time.blank? || end_time.blank?
    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
