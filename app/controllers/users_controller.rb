class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create display]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def display
    @users = User.where(nil)
    @users = @users.filter_by_group(params[:group]) if params[:group]
  end

  def new
    @user = User.new(:pulled => false)
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:error] = "Error- please try to create an account again."
      redirect_to new_user_path
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1 or /people/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to people_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def leave_group
    @user = User.find(params[:id])
    @user.update(group_id: nil)
    redirect_to @user
  end

  def remove_from_group
    user = User.find(params[:id])
    user.update(group_id: nil)
    redirect_to User.find(session[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :group_id, :first_name, :last_name, :uin, :classification)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end
