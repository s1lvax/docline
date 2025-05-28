class SendSubscriptionCanceledJob < ApplicationJob
  queue_as :default

  def perform(practitioner_profile_id)
    profile = PractitionerProfile.find(practitioner_profile_id)
    PractitionerMailer.subscription_canceled(profile).deliver_later
  end
end
