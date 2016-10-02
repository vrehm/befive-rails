class MembersController < ApplicationController

  def create
    if current_user.has_team
      flash[:alert] = "Action impossible, vous êtes déjà membre d'une équipe"
      redirect_to root_path
    elsif current_user.members.where("pending = ?", true).size > 0
      flash[:alert] = "Action impossible, vous avez déjà une demande en cours"
      redirect_to root_path
    else
      team = Team.find(params[:team_id])
      member = Member.new
      member.user = current_user
      member.team = team
      member.pending = true
      if member.save
        flash[:notice] = "La demande pour devenir membre de l'équipe #{team.name} à bien été envoyée !"
        redirect_to root_path
      else
        flash[:alert] = "Vous ne pouvez pas devenir membre de cette équipe"
        redirect_to team_path(team)
      end
    end
  end

  def update
    member = Member.find(params[:id])
    team = member.team
    if team.user == current_user
      member.validated = true
      member.pending = false
      member.user.has_team = true
      member.user.save
      if member.save
        flash[:notice] = "La demande à bien été validé !"
        redirect_to team_path(team)
      else
        flash[:alert] = "Action impossible, La demande n'a pas pu être validé !"
        redirect_to team_path(team)
      end
    else
      flash[:alert] = "Action impossible, vous n'êtes pas l'organisateur de cette équipe"
      redirect_to team_path(team)
    end
  end

  def destroy
    member = Member.find(params[:id])
    team = member.team
    if member.user == current_user && member.user.has_team == true
      member.user.has_team = false
      member.user.save
      member.destroy
      flash[:notice] = "Vous ne faites plus parti de #{team.name} !"
      redirect_to root_path
    elsif member.user == current_user || team.user == current_user
      member.user.has_team = false
      member.user.save
      member.destroy
      flash[:notice] = "La demande à bien été annulée !"
      redirect_to root_path
    else
      flash[:alert] = "Action impossible, vous n'êtes pas l'auteur de cette demande"
      redirect_to root_path
    end
  end
end
