class TeamsController < ApplicationController

  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_logos, only: [:new, :create, :edit, :update]
  before_action :set_locations, only: [:new, :create, :edit, :update]

  def index
    @teams = policy_scope(Team).order(created_at: :desc).paginate(:page => params[:page], :per_page => 8)
    @relationships = current_user.relationships.order(created_at: :desc)
  end

  def search
    @search_params = params[:query]
    @search_results = policy_scope(Team).global_search(@search_params).paginate(:page => params[:page], :per_page => 8)
    authorize @search_results
  end

  def show
    @invitation = Invitation.new(user: current_user, team: @team)
    @message = Message.new(user: current_user, recipient_email: @team.user.email)
    @members = @team.members.where("validated = ?", true)
    @members_pending = @team.members.where("pending = ?", true)
    @last_events = @team.events.where("date < ?", Date.today).order(date: :asc)
  end

  def new
    @team = Team.new
    authorize @team
  end

  def create
    @team = current_user.teams.build(team_params)
    authorize @team
    member = current_user.members.build(team: @team, validated: true)
    if @team.save && member.save
      current_user.update(has_team: true, manager: true)
      TeamMailer.creation_confirmation(@team.id).deliver_now
      flash[:notice] = "Félicitations #{current_user.first_name}, #{@team.name} à bien été crée !"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      flash[:notice] = "Modification réussie"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    current_user.update(has_team: false, manager: false)
    @team.members.each do |member|
      member.user.has_team = false
      member.user.save
    end
    @team.destroy
    flash[:notice] = "L'équipe #{@team.name} à bien été supprimée !"
    redirect_to root_path
  end

  private

  def set_team
    @team = Team.find(params[:id])
    authorize @team
  end

  def team_params
    params.require(:team).permit(:name, :city, :photo, :logo_id, :location_id)
  end

  def set_logos
    @logos = Logo.all
  end

  def set_locations
    @locations = Location.all
  end
end
