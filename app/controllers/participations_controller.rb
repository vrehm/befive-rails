class ParticipationsController < ApplicationController

  def select
    participation = Participation.find(params[:id])
    authorize(participation)
    participation.update(status: "selected")
    if participation.save
      redirect_to(:back)
    end
  end

  def unselect
    participation = Participation.find(params[:id])
    authorize(participation)
    participation.update(status: "selectionnable")
    if participation.save
      redirect_to(:back)
    end
  end
end
