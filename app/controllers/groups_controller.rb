class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.create(create_params)
    if @group.save
      flash[:notice] = "チャットグループが作成されました"
      redirect_to controller: "chats", action: "index"
    else
      flash[:alert] = @group.errors.full_messages
      redirect_to action: "new"
    end
  end

  private
  def create_params
    params.require(:chat_group).permit(:name, {:user_ids => []})
  end
end
