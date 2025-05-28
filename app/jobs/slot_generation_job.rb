# Only creates visible slots if use is subscribed
class SlotGenerationJob < ApplicationJob
  queue_as :default

  def perform(practitioner_availability_id)
    availability = PractitionerAvailability.find_by(id: practitioner_availability_id)
    return unless availability

    weeks_ahead = availability.weeks_ahead
    slot_minutes = availability.slot_duration_minutes
    profile = availability.practitioner_profile

    today = Time.zone.today
    holidays = profile.holidays.to_a

    # Only show slots if the profile is subscribed (license active)
    is_subscribed = profile.subscription_status == "active"

    # Remove existing future unbooked slots
    Slot.where(practitioner_availability_id: availability.id, user_id: nil).delete_all

    weeks_ahead.times do |week_offset|
      slot_date = (today.beginning_of_week(:monday) + availability.weekday.days + week_offset.weeks)
      start_dt = Time.zone.local(slot_date.year, slot_date.month, slot_date.day, availability.start_time.hour, availability.start_time.min)
      end_dt   = Time.zone.local(slot_date.year, slot_date.month, slot_date.day, availability.end_time.hour,   availability.end_time.min)

      current_start = start_dt

      while current_start + slot_minutes.minutes <= end_dt
        current_end = current_start + slot_minutes.minutes

        # -- SKIP IF THIS SLOT OVERLAPS WITH A HOLIDAY --
        slot_is_in_holiday = holidays.any? do |holiday|
          holiday_range = holiday.start_date.beginning_of_day..holiday.end_date.end_of_day
          holiday_range.cover?(current_start) || holiday_range.cover?(current_end - 1.second)
        end

        unless slot_is_in_holiday
          Slot.create!(
            practitioner_availability_id: availability.id,
            practitioner_profile_id: profile.id,
            start_time: current_start,
            end_time: current_end,
            visible: is_subscribed # Set visible according to license status
          )
        end

        current_start = current_end
      end
    end
  end
end
