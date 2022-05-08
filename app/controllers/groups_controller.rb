class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  # GET /groups or /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1 or /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)
    user = User.find(session[:user_id])

    respond_to do |format|
      if @group.save
        if user.admin
          format.html { redirect_to group_url(@group), notice: 'Group was successfully created.' }
        else

          code = SecureRandom.urlsafe_base64()
          while Group.find_by(code: code) != nil
            code = SecureRandom.urlsafe_base64()
          end

          @group.update(owner: user.full_name, pulled: false, email: user.get_email, code: code)
          user.update(group_id: @group[:id])
          user.Pull
          format.html { redirect_to user }
        end
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Clear all groups
  def clear_all_groups
    if Group.count == 0
      # Alert that groups were cleared and redirect to groups page on dashboard view
      flash[:alert] = "No groups available to delete."
      redirect_to '/groups'
      # redirect_to '/groups', :error => "No groups available to delete."
    else
      # Remove users from groups
      User.update_all(group_id: nil)
      puts "Set all group IDs of Users table entries to nil"

      # Delete all groups
      Group.delete_all
      puts "Deleted all entries from the Groups table in the database"

      # Remove students from seat assignments
      User.update_all(pulled: false)
      puts "Removed students seat assignments upon clearing groups"

      # Alert that groups were cleared and redirect to groups page on dashboard view
      flash[:notice] = "All groups successfully deleted."
      redirect_to '/groups'
      # redirect_to '/groups', :notice => "All groups successfully deleted."

    end
  end
  
  def pull_list
    user = User.find(session[:user_id])
    if not user.admin
      redirect_to new_session_path
    end

    @group_id = params[:id]

    group_members = User.where(group_id: @group_id)
    @group_uins = []
    for member in group_members
      @group_uins.push(member.uin)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:groupname, :pulled)
  end
end
