
class DeleteHolidaySlotsJob < ApplicationJob
  queue_as :default

  # Expects holiday and practitioner_profile
  def perform(holiday_id, practitioner_profile_id)
    holiday = Holiday.find_by(id: holiday_id)
    return unless holiday

    availabilities = PractitionerAvailability.where(practitioner_profile_id: practitioner_profile_id)

    # Delete availabilities where a user is not present (not booked)
    Slot.where(practitioner_availability_id: availabilities.select(:id))
        .where("start_time::date >= ? AND end_time::date <= ?", holiday.start_date, holiday.end_date)
        .where(user_id: nil)
        .delete_all
  end
end
