class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(create_params)
    if @group.save
      flash[:notice] = "チャットグループが作成されました"
      redirect_to group_path(@group)
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
      redirect_to group_path(@group)
    else
      flash[:alert] = @group.errors.full_messages
      flash[:alert_length] = "#{flash[:alert].length} error prohibited this chat_group from being saved:"
      redirect_to edit_group_path
    end
  end

  def show
    @group = Group.find(params[:id])
    if @group.users.include?(current_user)
      @groups = current_user.groups.all
      @messages = @group.messages
      @message = Message.new
      respond_to do |format|
        format.html
        format.json { render json: { messages: @messages, users: @messages.map{|message| message.user}, current_user: current_user}}
      end
    else
      redirect_to root_path
      flash[:alert] = "このグループに所属していません"
    end
  end

  def search
    if params.present?
      @users = User.where("name LIKE?", "%#{params.require(:user)[:name]}%")
    end
    respond_to do |format|
      format.html { redirect_to root_path}
      format.json { render json: { users: @users}}
    end
  end

  private
  def create_params
    params.require(:chat_group).permit(:name, {user_ids: []})
  end
end
