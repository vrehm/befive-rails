class TeamsController < ApplicationController

  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = policy_scope(Team).order(created_at: :desc)
  end

  def show
    @members = @team.members.where("validated = ?", true)
    @members_pending = @team.members.where("pending = ?", true)
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
      current_user.save
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
    current_user.save
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
    params.require(:team).permit(:name, :city, :photo)
  end
end
