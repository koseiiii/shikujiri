class PostsController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    if params[:search] == nil
      @posts= Post.order("created_at DESC").page(params[:page]).per(6)
    elsif params[:search] == ''
      @posts= Post.order("created_at DESC").page(params[:page]).per(6)
    else
      @posts = Post.where("genre LIKE ? ",'%' + params[:search] + '%').or(Post.joins(:user).where("user.name LIKE ? ", "%" + params[:search] + "%"))
      .or(Post.where("body LIKE ? ", "%" + params[:search] + "%")).or(Post.where("learn LIKE ? ", "%" + params[:search] + "%")).page(params[:page]).per(6)
    end
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)

    post.user_id = current_user.id

    if post.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to  user_path(current_user.id)
    else
      render "new"
    end
  end

  def destroy
    Post.find(params[:id]).destroy
  redirect_to action: :index
  end

  private
  def post_params
    params.require(:post).permit(:title, :when, :genre, :body, :learn, :user_id ,:image)
  end

end
