class MessagesController < ApplicationController
  def create
    if params[:team_id]
      @user = Team.find(params[:team_id]).user
    else
      @user = User.find(params[:user_id])
    end
    @message = Message.new(message_params)
    @message.user = current_user
    @message.recipient_email = @user.email
    @message.recipient_first_name = @user.first_name
    authorize @message
    if @message.save
      ContactMailer.user_contact(@message.id).deliver_now
      flash[:notice] = "Votre message a bien été envoyé par mail à #{@user.first_name}"
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
