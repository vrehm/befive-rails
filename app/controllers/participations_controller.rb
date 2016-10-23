class ParticipationsController < ApplicationController

  def select
    participation = Participation.find(params[:id])
    authorize(participation)
    participation.update(status: "selected", waiting_list: false, sent: false, pending: false)
    redirect_to(:back)
  end

  def select_all
    event = Event.find(params[:event_id])
    selectionnable_participations = policy_scope(Participation).where(event: event, status: "selectionnable")
    authorize(selectionnable_participations)
    selectionnable_participations.each do |participation|
      participation.update(status: "selected", waiting_list: false, sent: false, pending: false)
    end
    redirect_to(:back)
  end

  def waiting_list
    participation = Participation.find(params[:id])
    authorize(participation)
    participation.update(status: "selected", waiting_list: true, validated: false, refused: false, pending: false, sent: false)
    redirect_to(:back)
  end

  def unselect
    participation = Participation.find(params[:id])
    authorize(participation)
    participation.update(status: "selectionnable", pending: false, validated: false, refused: false, sent: false, waiting_list: false)
    redirect_to(:back)
  end

  def send_all
    event = Event.find(params[:event_id])
    selected_participations = policy_scope(Participation).where(event: event, status: "selected", pending: false, validated: false, refused: false)
    authorize(selected_participations)
    selected_participations.each do |participation|
      participation.update(sent: true, pending: true)
      if participation.waiting_list
        EventMailer.waiting_list(participation.id).deliver_now
      else
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
    flash[:notice] = "Vous venez d'accepter de participer à cet évenement "
    redirect_to(:back)
  end

  def refuse
    participation = Participation.find(params[:id])
    authorize(participation)
    participation.update(pending: false, refused: true, validated: false)
    # Move last member from waiting_list to participations
    waiting_list_participations = policy_scope(Participation).where(event: participation.event, status: "selected", waiting_list: true).order("updated_at asc")
    if waiting_list_participations.any?
      first_on_list_participation = waiting_list_participations.first
      first_on_list_participation.update(status: "selected", waiting_list: false, sent: true, pending: true)
      EventMailer.participation(first_on_list_participation.id).deliver_now
    end
    flash[:notice] = "Vous venez de refuser de participer à cet évenement"
    redirect_to(:back)
  end
end
