# app/jobs/slot_deletion_job.rb
class SlotDeletionJob < ApplicationJob
  queue_as :default

  def perform(practitioner_availability_id)
    Slot.where(practitioner_availability_id: practitioner_availability_id).delete_all
  end
end
