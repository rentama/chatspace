class ChatsController < ApplicationController
  def index
    @message = Message.new
  end

  def create
    Message.create(create_params)
    redirect_to :action => "index"
  end

  private
  def create_params
      params.require(:message).permit(:body)
  end
end
