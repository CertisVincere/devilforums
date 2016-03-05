class GroupsController < ApplicationController
  before_action :logged_in_user

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "Group successfully created."
      redirect_to @group
    else
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
    @topics = @group.topics.paginate(page: params[:page])
  end

  def index
    if current_user.nil?
      redirect_to login_url
    else
      @user = current_user
      if params[:query].present?
        @groups = Group.search(params[:query])
      else
        @groups = @user.groups.paginate(page: params[:page])
      end
    end
  end

  def search
  end

  def destroy
    Group.find(params[:id]).destroy
    flash[:success] = "Group deleted"
    redirect_to groups_url
  end

  private

  def group_params
    params.require(:group).permit(:name, :category, :description, :user_id)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in first."
      redirect_to login_url
    end
  end

end
