class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize(@user)
    @message = Message.new(user: current_user, recipient_email: @user.email, recipient_first_name: @user.first_name)
    if current_user.members.any?
      @team = @user.members.first.team
    end
  end
end
