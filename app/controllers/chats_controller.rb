class ChatsController < ApplicationController
  def index
    @message = Message.new
    @groups = current_user.groups
  end

  def create
    @message = Message.new(create_params)
    @group = @message.group
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_path(@group) }
        format.json { render json: { body: @message.body, user_name: @message.user.name, created_at: @message.created_at}}
      end
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
