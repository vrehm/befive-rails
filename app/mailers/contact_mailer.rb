class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.team_contact.subject
  #
  def team_contact(message_id)
    @message = Message.find(message_id)

    mail(
      to:       @message.recipient_email,
      subject:  "#{@message.user.first_name} vous a contacté !"
    )
  end
end
