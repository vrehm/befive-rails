class TeamMailer < ApplicationMailer

  def creation_confirmation(team_id)
    @team = Team.find(team_id)

    mail(
      to:       @team.user.email,
      subject:  "#{@team.name} à bien été crée !"
    )
  end
end
