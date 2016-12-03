class ChatsController < ApplicationController
  def index
    @message = Message.new
    @groups = Group.all
  end

  def create
    @message = Message.new(create_params)
    @group = @message.group
    if @message.save
      redirect_to group_path(@group)
    else
      flash[:alert] = "メッセージを入力してください"
      redirect_to group_path(@group)
    end
  end

  private
  def create_params
      params.require(:message).permit(:body, :group_id).merge(user_id: current_user.id)
  end
end
