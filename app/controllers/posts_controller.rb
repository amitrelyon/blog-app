class PostsController < ApplicationController

  http_basic_authenticate_with name: "amit", password: "aryan", except: [:index, :show]

  before_action :set_post_attr, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_user
  def index
    @posts = Post.paginate(page: params[:page], per_page: 3)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:success] = "Post has been Created Successfully"
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def show

  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post has been updated Successfully"
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post has been deleted Successfully"
    redirect_to posts_path(@user)
  end


  private

  def post_params
    params.require(:post).permit(:description, :image, :file_name)
  end

  def set_post_attr
    @post = Post.find(params[:id])
  end

  def require_same_user
    if current_user != @post.user && !current_user.admin?
      flash[:danger] = "You can only edit or delete your own Post"
      redirect_to users_path
    end
  end

end
