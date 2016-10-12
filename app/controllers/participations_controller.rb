class ParticipationsController < ApplicationController

  def select
    participation = Participation.find(params[:id])
    authorize(participation)
    participation.update(status: "selected", waiting_list: false, sent: false, pending: false)
    if participation.save
      redirect_to(:back)
    end
  end

  def waiting_list
    participation = Participation.find(params[:id])
    authorize(participation)
    participation.update(status: "selected", waiting_list: true, validated: false, refused: false, pending: false, sent: false)
    if participation.save
      redirect_to(:back)
    end
  end

  def unselect
    participation = Participation.find(params[:id])
    authorize(participation)
    participation.update(status: "selectionnable", pending: false, validated: false, refused: false, sent: false, waiting_list: false)
    if participation.save
      redirect_to(:back)
    end
  end

  def send_all
    event = Event.find(params[:event_id])
    selected_participations = policy_scope(Participation).where(event: event, status: "selected", pending: false, validated: false, refused: false)
    authorize(selected_participations)
    selected_participations.each do |participation|
      participation.update(sent: true, pending: true)
      participation.save
      if participation.waiting_list == false
        EventMailer.participation(participation.id).deliver_now
      end
    end
    flash[:notice] = "Les convocations ont bien été envoyées par mail!"
    redirect_to(:back)
  end

  def validate
    participation = Participation.find(params[:id])
    authorize(participation)
    participation.update(pending: false, validated: true, refused: false)
    if participation.save
      flash[:notice] = "Vous venez d'accepter de participer à cet évenement "
      redirect_to(:back)
    end
  end

  def refuse
    participation = Participation.find(params[:id])
    authorize(participation)
    participation.update(pending: false, refused: true, validated: false)
    if participation.save
      flash[:notice] = "Vous venez de refuser de participer à cet évenement"
      redirect_to(:back)
    end
  end

end
