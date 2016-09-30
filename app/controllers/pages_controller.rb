class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user.members.first.team
      @team = current_user.members.first.team
    else
      @team = "Mon équipe"
    end
  end
end
