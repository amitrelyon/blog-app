class UsersController < ApplicationController
  http_basic_authenticate_with name: "amit", password: "aryan", except: [:index, :show]
  before_action :set_user_data, only: [:show, :edit, :update, :destroy,]
  # If user is not login then can't access any page but they can go ahead for signiup page
  before_action :require_user, except: [:new, :create]
  # User can not delete their own account
  before_action :require_same_user, only: [:edit, :update, :destroy]
  # Only Admin can Destroy the Users
  before_action :require_admin, only: [:destroy]
  # Restrict User to go to the signup page if user is already loggedin
  before_action :restrict_user, only: [:new]

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def show
    @user_post_details = @user.posts.paginate(page: params[:page], per_page: 3)
  end

  def edit

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.name} to Blog App!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your profile was updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if !@user.admin?
      @user.destroy
      flash[:success] = "User and all associated Posts have been deleted"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user_data
    @user = User.find(params[:id])
  end


  def emp_params
    params.require(:employee).permit(:name, :email, :password, :password_confirmation)
  end

  def set_emp
    @employee = Employee.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only edit or delete your own account"
      redirect_to users_path
    end
  end

  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "Only hr users can perform that action"
      redirect_to root_path
    end
  end

  def restrict_user
    if logged_in?
      flash[:danger] = "you are not autherized to do this"
      redirect_to root_path
    end
  end

end
