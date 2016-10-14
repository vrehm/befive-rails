class MessagesController < ApplicationController
  def create
    @team = Team.find(params[:team_id])
    @message = Message.new(message_params)
    @message.user = current_user
    @message.recipient_email = @team.user.email
    @message.recipient_first_name = @team.user.first_name
    authorize @message
    if @message.save
      ContactMailer.team_contact(@message.id).deliver_now
      flash[:notice] = "Votre message a bien été envoyé par mail à #{@team.user.first_name} de #{@team.name}"
      redirect_to(:back)
    else
      flash[:notice] = "Votre message n'a pas pu être envoyé"
      redirect_to(:back)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
