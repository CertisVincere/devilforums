class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :create, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @groups = @user.groups.paginate(page: params[:page])
    @posts = @user.posts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if current_user.admin
      if @user.save
        flash[:success] = "User successfully created."
        redirect_to @user
      else
        render 'new'
      end
    else
      flash[:danger] = "You are not authorized to create users."
      redirect_to root_url
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Password updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in first."
      redirect_to login_url
    end
  end

  def correct_user
    unless current_user.admin
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = "You do not have permission to view this page"
      redirect_to(root_url)
    end
  end
end
