class PractitionerAvailability < ApplicationRecord
  belongs_to :practitioner_profile
  has_many :slots, dependent: :destroy

  validates :weekday, presence: true, inclusion: { in: 0..6 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :slot_duration_minutes, presence: true,
            numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 480 }
  validates :weeks_ahead, presence: true,
            numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 52 }

  validate  :end_time_after_start_time
  validate  :not_overlapping_existing_availabilities
  validate  :max_six_per_weekday

  after_commit :generate_slots, on: [ :create, :update ]
  after_destroy :delete_slots

  def generate_slots
    SlotGenerationJob.perform_later(self.id)
  end

  def delete_slots
    SlotDeletionJob.perform_later(self.id)
  end

  private

  def end_time_after_start_time
    return if start_time.blank? || end_time.blank?
    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end

  def not_overlapping_existing_availabilities
    return if start_time.blank? || end_time.blank? || weekday.blank?
    overlaps = practitioner_profile.practitioner_availabilities
      .where(weekday: weekday)
      .where.not(id: id)
      .where("NOT (end_time <= ? OR start_time >= ?)", start_time, end_time)
    if overlaps.exists?
      errors.add(:base, "This availability overlaps with another one on the same day")
    end
  end

  def max_six_per_weekday
    return if weekday.blank?
    count = practitioner_profile.practitioner_availabilities
              .where(weekday: weekday)
              .where.not(id: id)
              .count
    if count >= 6
      errors.add(:base, "Cannot have more than 6 availabilities per day")
    end
  end
end
