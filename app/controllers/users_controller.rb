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

  def reassign_group_ownership(user)
    # if user is group owner, reassign group ownership before leaving group
    
    if user.group_id == nil
      return
    end

    previous_group = Group.find(user.group_id)
    
    if previous_group.email == user.get_email
      begin
        next_user = User.where.not(id: user.id).find_by!(group_id: previous_group.id)
        previous_group.update(owner: next_user.get_first_name + " " + next_user.get_last_name, email: next_user.get_email)
      rescue ActiveRecord::RecordNotFound
        @user.update(group_id: nil)
        previous_group.destroy
      end
    end
  end


  def leave_group
    @user = User.find(params[:id])

    reassign_group_ownership(@user)

    @user.update(group_id: nil)
    redirect_to @user
  end

  def remove_from_group
    user = User.find(params[:id])
    user.update(group_id: nil)
    redirect_to User.find(session[:user_id])
  end

  # def join_group
  # end

  def add_to_group
    user = User.find(params[:id]) 

    begin
      new_group = Group.find_by!(code: params[:code])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Error: please enter a valid group code."
      redirect_to join_group_path(user)
      return
    end
    
    reassign_group_ownership(user)

    user.update(group_id: new_group.id)

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
