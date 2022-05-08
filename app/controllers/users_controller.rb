class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create display displayqr update_pull_status]
  skip_before_action :verify_authenticity_token, only: [:update_pull_status]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def update_pull_status
    success = params[:success]
    already_pulled = params[:already_pulled]

    puts "data updated"
  end

  def displayqr
    @user = User.find(params[:id])
    @qr = RQRCode::QRCode.new("https://list-eaters.herokuapp.com/groups/#{@user.group_id}/pull_list")
  end

  def new
    @user = User.new(pulled: false)
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
      flash[:error] = 'Error- please try to create an account again.'
      redirect_to new_user_path
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
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
      format.html { redirect_to people_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reassign_group_ownership
    user = User.find(params[:id])
    group = Group.find(user[:group_id])
    group.update(owner: user.full_name, email: user.get_email)
    redirect_to User.find(session[:user_id])
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

  def join_group
    @user = User.find(params[:id])
  end

  def add_to_group
    user = User.find(params[:id])

    begin
      new_group = Group.find_by!(code: params[:code])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'Error: please enter a valid group code.'
      redirect_to join_group_path(user)
      return
    end

    user.update(group_id: new_group.id)

    user.Pull

    redirect_to user
  end

  private

  def user_params
    params.require(:user).permit(:uin, :pulled, :group_id, :admin)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end
