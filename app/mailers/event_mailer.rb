class EventMailer < ApplicationMailer

  def participation(participation_id)
    @participation = Participation.find(participation_id)

    mail(
      to:       @participation.user.email,
      subject:  "Vous êtes convoqué pour un #{@participation.event.category} avec #{@participation.event.team.name}!"
    )
  end
end
