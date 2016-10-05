class RelationshipsController < ApplicationController
  def create
    team = Team.find(params[:team_id])
    relationship = Relationship.new(user: current_user, team: team)
    authorize(relationship)
    relationship.save
    flash[:notice] = "#{team.name} à bien été ajouté à votre réseau !"
    redirect_to teams_path
  end

  def destroy
    relationship = Relationship.find(params[:id])
    team = relationship.team
    authorize(relationship)
    relationship.destroy
    flash[:notice] = "#{team.name} à bien été supprimé de votre réseau !"
    redirect_to teams_path
  end
end
