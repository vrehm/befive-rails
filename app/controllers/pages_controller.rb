class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in? && current_user.members.any?
      @team = current_user.members.first.team
      @members = @team.members.where("validated = ?", true)
      @invitation = Invitation.new(user: current_user, team: current_user.teams.first)
      @relationships = current_user.relationships.order(created_at: :desc)
      if current_user.has_team
        # Events
        @user_events = policy_scope(Event).where(team: current_user.members.first.team)
        @today_user_events = @user_events.where('date = ?', Date.today)
        @next_events = @user_events.where("date >= ?", Date.today).order(date: :asc)
        @next_event = @next_events.first
        @activities = Activity.where(team: current_user.members.first.team).order("created_at desc")
      end
    end
  end
end
