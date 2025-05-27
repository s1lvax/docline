# app/jobs/slot_regeneration_job.rb
class SlotRegenerationJob < ApplicationJob
  queue_as :default

  def perform(practitioner_availability_id)
    availability = PractitionerAvailability.find(practitioner_availability_id)

    # Delete all future, unbooked slots for this availability
    Slot.where(practitioner_availability_id: availability.id)
      .where("start_time >= ?", Time.zone.now)
      .where(user_id: nil)
      .delete_all

    # Re-create new slots based on updated availability
    SlotGenerationJob.perform_now(availability.id)
  end
end
