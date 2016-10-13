class EventMailer < ApplicationMailer

  def participation(participation_id)
    @participation = Participation.find(participation_id)

    mail(
      to:       @participation.user.email,
      subject:  "Vous êtes convoqué pour un #{@participation.event.category} avec #{@participation.event.team.name}!"
    )
  end

  def waiting_list(participation_id)
    @participation = Participation.find(participation_id)

    mail(
      to:       @participation.user.email,
      subject:  "Vous êtes sur la liste d'attente pour un #{@participation.event.category} avec #{@participation.event.team.name}!"
    )
  end

  def edit(participation_id)
    @participation = Participation.find(participation_id)

    mail(
      to:       @participation.user.email,
      subject:  "Le #{@participation.event.category} avec #{@participation.event.team.name} a été modifié !"
    )
  end

  def cancel(participation_id)
    @participation = Participation.find(participation_id)

    mail(
      to:       @participation.user.email,
      subject:  "Le #{@participation.event.category} avec #{@participation.event.team.name} a été annulé !"
    )
  end

end
