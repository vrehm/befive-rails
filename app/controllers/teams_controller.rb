class TeamsController < ApplicationController

  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.members.size > 0
      @team = current_user.members.first.team
    end
    @teams = Team.all
  end

  def show
    @members = @team.members.where("validated = ?", true)
    @members_pending = @team.members.where("pending = ?", true)
  end

  def new
    if current_user.has_team
      flash[:alert] = "Action impossible, vous êtes déjà memebre d'une équipe"
      redirect_to root_path
    else
      @team = Team.new
    end
  end

  def create
    if current_user.has_team
      flash[:alert] = "Action impossible, vous êtes déjà membre d'une équipe"
      redirect_to root_path
    else
      @team = Team.new(team_params)
      @team.user = current_user
      if @team.save
        member = Member.new
        member.user = current_user
        member.team = @team
        member.validated = true
        member.save
        current_user.has_team = true
        current_user.manager = true
        current_user.save
        flash[:notice] = "Félicitations #{current_user.first_name}, #{@team.name} à bien été crée !"
        redirect_to root_path
      else
        render 'new'
      end
    end
  end

  def edit

  end

  def update
    if current_user == @team.user
      if @team.update(team_params)
        flash[:notice] = "Modification réussie"
        redirect_to root_path
      else
        render 'edit'
      end
    else
      flash[:alert] = "Action impossible, vous n'etes pas l'organisateur de cette équipe"
      redirect_to root_path
    end
  end

  def destroy
    if current_user == @team.user
      current_user.has_team = false
      current_user.manager = false
      current_user.save
      @team.members.each do |member|
        member.user.has_team = false
        member.user.save
      end
      @team.destroy
      flash[:notice] = "L'équipe #{@team.name} à bien été supprimée !"
      redirect_to root_path
    else
      flash[:alert] = "Action impossible, vous n'etes pas l'organisateur de cette équipe"
      redirect_to root_path
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :city, :photo)
  end
end
