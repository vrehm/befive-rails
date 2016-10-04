class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in? && current_user.members.size > 0
      @team = current_user.members.first.team
      @members = @team.members.where("validated = ?", true)
      @invitation = Invitation.new(user: current_user, team: current_user.teams.first)
    end
  end
end
