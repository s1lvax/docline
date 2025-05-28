class PractitionerMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.practitioner_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    mail(
      subject: "Welcome to Docline!",
      to: @user.email_address,
      track_opens: "true",
      message_stream: "outbound"
    )
  end

  def subscription_invoice(profile, invoice_pdf_url)
    @profile = profile
    @invoice_pdf_url = invoice_pdf_url
    mail(
      to: profile.user.email_address,
      subject: "Your Docline Subscription Invoice"
    ) do |format|
      format.text
      format.html
    end
  end

  def subscription_canceled(profile)
    @profile = profile
    mail(
      to: profile.user.email_address,
      subject: "Your Docline Subscription Has Been Canceled"
    ) do |format|
      format.text
      format.html
    end
  end
end
