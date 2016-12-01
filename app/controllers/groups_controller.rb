class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(create_params)
    if @group.save
      flash[:notice] = "チャットグループが作成されました"
      redirect_to root_path
    else
      flash[:alert] = @group.errors.full_messages
      flash[:alert_length] = "#{flash[:alert].length} error prohibited this chat_group from being saved:"
      redirect_to new_group_path
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
      redirect_to root_path
    else
      flash[:alert] = @group.errors.full_messages
      flash[:alert_length] = "#{flash[:alert].length} error prohibited this chat_group from being saved:"
      redirect_to edit_group_path
    end
  end

  private
  def create_params
    params.require(:chat_group).permit(:name, {user_ids: []})
  end
end
