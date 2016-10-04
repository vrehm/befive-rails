class InvitationsController < ApplicationController
  before_action :set_teams, only: [:new, :create]
  
  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.user = current_user
    @invitation.team = @team
    authorize @invitation
    if @invitation.save
      InvitationMailer.team_member(@invitation.id).deliver_now
      flash[:notice] = "L'invitation a bien été envoyée par mail à #{@invitation.first_name} #{@invitation.last_name}"
      redirect_to team_path(@team)
    else
      flash[:notice] = "L'invitation n'a pas pu être envoyée"
      redirect_to team_path(@team)
    end
  end

  private

  def set_teams
    @team = Team.find(params[:team_id])
  end

  def invitation_params
    params.require(:invitation).permit(:email, :first_name, :last_name)
  end
end
