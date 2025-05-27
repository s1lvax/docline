
class SlotGenerationJob < ApplicationJob
  queue_as :default

  def perform(practitioner_availability_id)
    availability = PractitionerAvailability.find_by(id: practitioner_availability_id)
    return unless availability

    weeks_ahead = availability.weeks_ahead
    slot_minutes = availability.slot_duration_minutes
    profile = availability.practitioner_profile

    # Always use the app's time zone!
    today = Time.zone.today

    # Remove existing future slots
    Slot.where(practitioner_availability_id: availability.id, user_id: nil).delete_all

    # Loop for each week ahead
    weeks_ahead.times do |week_offset|
      # The date for the correct weekday this week
      slot_date = (today.beginning_of_week(:monday) + availability.weekday.days + week_offset.weeks)

      # Use only hour and min from availability.start_time and end_time, on the slot_date
      start_dt = Time.zone.local(slot_date.year, slot_date.month, slot_date.day, availability.start_time.hour, availability.start_time.min)
      end_dt   = Time.zone.local(slot_date.year, slot_date.month, slot_date.day, availability.end_time.hour,   availability.end_time.min)

      current_start = start_dt

      while current_start + slot_minutes.minutes <= end_dt
        current_end = current_start + slot_minutes.minutes
        Slot.create!(
          practitioner_availability_id: availability.id,
          practitioner_profile_id: profile.id,
          start_time: current_start,
          end_time: current_end
        )
        current_start = current_end
      end
    end
  end
end
