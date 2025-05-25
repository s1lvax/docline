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
end
