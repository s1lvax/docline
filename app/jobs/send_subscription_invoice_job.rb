class SendSubscriptionInvoiceJob < ApplicationJob
  queue_as :default

  def perform(practitioner_profile_id)
    profile = PractitionerProfile.find(practitioner_profile_id)
    return unless profile.stripe_subscription_id.present?

    # Get latest invoice from Stripe
    subscription = Stripe::Subscription.retrieve(profile.stripe_subscription_id)
    latest_invoice_id = subscription.latest_invoice
    invoice = Stripe::Invoice.retrieve(latest_invoice_id)

    # PDF URL (public, expiring link)
    invoice_pdf_url = invoice.invoice_pdf

    PractitionerMailer.subscription_invoice(profile, invoice_pdf_url).deliver_later
  end
end
