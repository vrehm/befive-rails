class EventsController < ApplicationController

  before_action :set_locations, only: [:new, :create, :edit, :update]

  def index
    @team = current_user.members.first.team
    @user_events = policy_scope(Event).where(team: current_user.members.first.team)
    @next_events = @user_events.where("datetime >= ?", DateTime.now.beginning_of_day).order(datetime: :asc)
    @next_event = @next_events.first
    @last_events = @user_events.where("datetime < ?", DateTime.now.beginning_of_day).order(datetime: :asc)
  end

  def show
    @event = Event.find(params[:id])
    authorize(@event)
  end

  def new
    @event = Event.new(user: current_user, team: current_user.teams.first)
    authorize(@event)
  end

  def create
    @event = current_user.events.build(event_params)
    @event.team = current_user.teams.first
    authorize(@event)
    if @event.save
      flash[:notice] = "Félicitations #{current_user.first_name}, vous avez crée un nouvel évenement pour #{@event.team.name} !"
      redirect_to @event
    else
      render 'new'
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:category, :datetime, :address, :location_id)
  end

  def set_locations
    @locations = Location.all
  end
end
