class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(create_params)
    if @group.save
      flash[:notice] = "チャットグループが作成されました"
      redirect_to controller: "chats", action: "index"
    else
      flash[:alert] = @group.errors.full_messages
      flash[:alert_length] = "#{flash[:alert].length} error prohibited this chat_group from being saved:"
      redirect_to action: "new"
    end
  end

  def edit
    @group =Group.find(params[:id])
    @users = @group.users
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(create_params)
      flash[:notice] = "チャットグループが更新されました"
      redirect_to controller: "chats", action: "index"
    else
      flash[:alert] = @group.errors.full_messages
      flash[:alert_length] = "#{flash[:alert].length} error prohibited this chat_group from being saved:"
      redirect_to action: "edit"
    end
  end

  private
  def create_params
    params.require(:chat_group).permit(:name, {user_ids: []})
  end
end
