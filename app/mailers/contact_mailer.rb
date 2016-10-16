class ContactMailer < ApplicationMailer

  def user_contact(message_id)
    @message = Message.find(message_id)

    mail(
      to:       @message.recipient_email,
      subject:  "#{@message.user.first_name} vous a contacté !"
    )
  end
end
