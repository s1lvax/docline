class PractitionerProfile < ApplicationRecord
  belongs_to :user
  has_rich_text :bio
  has_many :practitioner_availabilities

  has_one_attached :profile_picture

  validates :bio, length: { maximum: 1000 }
  validates :profession, length: { maximum: 255 }

  # Send the invoice per mail
  after_update :send_invoice_if_subscription_activated

  def subscription_active?
    subscription_status == "active"
  end

  def send_invoice_if_subscription_activated
    if saved_change_to_subscription_status? && subscription_status == "active"
      SendSubscriptionInvoiceJob.perform_later(id)
    end
  end
end
