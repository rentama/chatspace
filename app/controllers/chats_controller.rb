class ChatsController < ApplicationController
  def index
    @message = Message.new
  end

  def create
    @message = Message.new(create_params)
    if @message.save
      redirect_to action: "index"
    else
      flash[:notice] = "メッセージを入力してください"
      redirect_to action: "index"
    end
  end

  private
  def create_params
      params.require(:message).permit(:body)
  end
end
