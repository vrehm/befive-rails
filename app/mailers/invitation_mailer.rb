class InvitationMailer < ApplicationMailer
  def team_member(invitation_id)
    @invitation = Invitation.find(invitation_id)

    mail(
      to:       @invitation.email,
      subject:  "#{@invitation.user.first_name} vous invite à rejoindre son équipe de Foot 5 !"
    )
  end
end
