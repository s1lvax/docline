class MakeSlotsVisibleJob < ApplicationJob
  queue_as :default

  def perform(practitioner_profile_id)
    # Only affect future unbooked slots (so we don't touch past appointments)
    Slot.where(
      practitioner_profile_id: practitioner_profile_id,
      user_id: nil
    ).where("end_time >= ?", Time.zone.now)
     .update_all(visible: true)
  end
end
