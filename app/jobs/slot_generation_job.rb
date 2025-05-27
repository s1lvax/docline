# app/jobs/slot_generation_job.rb
class SlotGenerationJob < ApplicationJob
  queue_as :default

  def perform(practitioner_availability_id)
    availability = PractitionerAvailability.find_by(id: practitioner_availability_id)
    return unless availability

    weeks = availability.weeks_ahead
    slot_minutes = availability.slot_duration_minutes
    profile = availability.practitioner_profile

    today = Date.today

    # Remove existing future slots (to prevent duplicates on update)
    Slot.where(practitioner_availability_id: availability.id)
        .where("start_time >= ?", Time.zone.now)
        .delete_all

    weeks.times do |week|
      slot_date = today.beginning_of_week + availability.weekday.days + week.weeks
      start_dt = slot_date.to_datetime.change(hour: availability.start_time.hour, min: availability.start_time.min)
      end_dt   = slot_date.to_datetime.change(hour: availability.end_time.hour, min: availability.end_time.min)

      current_start = start_dt
      while current_start + slot_minutes.minutes <= end_dt
        current_end = current_start + slot_minutes.minutes

        # Prevent duplicates (extra safety)
        unless Slot.exists?(practitioner_availability_id: availability.id, start_time: current_start, end_time: current_end)
          Slot.create!(
            practitioner_availability_id: availability.id,
            practitioner_profile_id: profile.id,
            start_time: current_start,
            end_time: current_end
          )
        end
        current_start = current_end
      end
    end
  end
end
