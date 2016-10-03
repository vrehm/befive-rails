class MembersController < ApplicationController

  def create
    team = Team.find(params[:team_id])
    member = team.members.build(user: current_user, team: team, pending: true)
    authorize member
    if member.save
      flash[:notice] = "La demande pour devenir membre de l'équipe #{team.name} à bien été envoyée !"
      redirect_to root_path
    else
      flash[:alert] = "Vous ne pouvez pas devenir membre de cette équipe"
      redirect_to team_path(team)
    end
  end

  def update
    member = Member.find(params[:id])
    team = member.team
    authorize member
    member.user.has_team = true
    member.update(validated: true, pending: false)
    if member.save && member.user.save
      flash[:notice] = "La demande à bien été validé, #{member.user.first_name} est maintenant membre de votre équipe !"
    else
      flash[:alert] = "Action impossible, La demande n'a pas pu être validé !"
    end
    redirect_to team_path(team)
  end

  def destroy
    member = Member.find(params[:id])
    team = member.team
    authorize member
    member.user.has_team = false
    member.user.save
    member.destroy
    if current_user == team.user
      flash[:notice] = "La demande a bien été refusé !"
      redirect_to team_path(team)
    else
      flash[:notice] = "Votre demande pour devenir membre de #{team.name} a bien été annulé !"
      redirect_to root_path
    end
  end
end
