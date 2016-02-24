class PostsController < ApplicationController
  before_action :logged_in_user
  respond_to :html, :js

  def index
    @group = Group.find(params[:group_id])
    @topic = Topic.find(params[:topic_id])
    @posts = @topic.posts
  end

  def new
    @group = Group.find(params[:group_id])
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id]) 
    @topic = Topic.find(params[:topic_id])
    @post = Post.create(post_params)
    @post.user_id = current_user.id
    @posts = @topic.posts
  end

  def show
    @group = Group.find(params[:group_id])
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

  def destroy
    @group = Group.find(params[:group_id])
    @topic = Topic.find(params[:topic_id])
    Post.find(params[:id]).destroy
    redirect_to group_topic_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:name, :content, :attachment, :user_id, :group_id, :topic_id)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in first."
      redirect_to login_url
    end
  end

end
