class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :practitioner_profile, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # roles
  enum :role, { patient: 0, practitioner: 1 }

  # Send welcome mail and create practitioner profile if practitioner
  after_create_commit :create_practitioner_profile, :send_welcome_mail, if: :practitioner?

  private

  # Function that triggers welcome mail job if its a practitioner
  def send_welcome_mail
    PractitionerMailer.welcome(self).deliver_later
  end

  def create_practitioner_profile
    CreatePractitionerProfileJob.perform_later(self.id)
  end
end
