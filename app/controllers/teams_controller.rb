class TeamsController < ApplicationController

  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all
  end

  def show

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
      flash[:alert] = "Action impossible, vous êtes déjà memebre d'une équipe"
      redirect_to root_path
    else
      @team = Team.new(team_params)
      @team.user = current_user
      if @team.save
        member = Member.new
        member.user = current_user
        member.team = @team
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

  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :city)
  end
end
