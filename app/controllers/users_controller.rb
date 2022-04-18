class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create display]

  def show; end

  def index; end

  def display
    @users = User.where(nil)
    @users = @users.filter_by_group(params[:group]) if params[:group]
  end

  def new
    @user = User.new(pulled: false)
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:error] = 'Error- please try to create an account again.'
      redirect_to new_user_path
    end
  end

  def leave_group
    @user = User.find(params[:id])
    @user.update(group_id: nil)
    redirect_to @user
  end

  def remove_from_group
    user = User.find(params[:member_id])
    user.update(group_id: nil)
    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
