class EventsController < ApplicationController

  before_action :set_locations, only: [:new, :create, :edit, :update]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @team = current_user.members.first.team
    @user_events = policy_scope(Event).where(team: current_user.members.first.team)
    @next_events = @user_events.where("date >= ?", Date.today).order(date: :asc)
    @next_event = @next_events.first
    @last_events = @user_events.where("date < ?", Date.today).order(date: :asc)
  end

  def show
    @event = Event.find(params[:id])
    @team = current_user.members.first.team
    authorize(@event)
    @selectionnable_participations = policy_scope(Participation).where(event: @event, status: "selectionnable")
    @selected_participations = policy_scope(Participation).where(event: @event, status: "selected")
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
      # Create participations for selectionnable members
      @event.team.members.each do |member|
        participation = Participation.new(event: @event, user: member.user, status: "selectionnable")
        participation.save
      end
      # Create Activity "new event"
      activity = Activity.new(user: @event.user, team: @event.team, event: @event, category: "new_event")
      activity.save
      flash[:notice] = "Félicitations #{current_user.first_name}, vous avez crée un nouvel évenement pour #{@event.team.name} !"
      redirect_to @event
    else
      render 'new'
    end
  end

  def edit
    authorize(@event)
  end

  def update
    authorize(@event)
    @event.update(event_params)
    if @event.save
      flash[:notice] = "L'évenement à bien été mis à jour !"
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    authorize(@event)
    @event.destroy
    flash[:notice] = "L'évenement à bien été annulé !"
    redirect_to events_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:category, :date, :time, :address, :location_id)
  end

  def set_locations
    @locations = Location.all
  end
end
