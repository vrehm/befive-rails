class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in? && current_user.members.size > 0
      @team = current_user.members.first.team
      @members = @team.members.where("validated = ?", true)
      @invitation = Invitation.new(user: current_user, team: current_user.teams.first)
      @relationships = current_user.relationships.order(created_at: :desc)
      if current_user.has_team
        # Events
        @user_events = policy_scope(Event).where(team: current_user.members.first.team)
        @today_user_events = @user_events.where('datetime BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day)
        @next_events = @user_events.where("datetime >= ?", DateTime.now.beginning_of_day).order(datetime: :asc)
        @next_event = @next_events.first
      end
    end
  end
end
