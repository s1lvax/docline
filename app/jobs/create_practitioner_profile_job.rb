class CreatePractitionerProfileJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)
    return unless user&.practitioner?

    # Create PractitionerProfile only if it doesnt exist (should never but just as safety precaution)
    PractitionerProfile.find_or_create_by!(user: user)
  end
end
