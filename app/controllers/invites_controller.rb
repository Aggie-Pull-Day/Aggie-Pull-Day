class InvitesController < ApplicationController

  def new
  end

  def create
    invitee = params[:email]
    inviter = User.find(session[:user_id]).get_email
    group_id = User.find(session[:user_id]).group_id

    invite = Invite.create(group_id: group_id, inviter: inviter, invitee: invitee, inviter_accepted: true, invitee_accepted: false)
    if not Student.find_by(email: invitee) == nil

        group = Group.find(group_id)
        InviteMailer.with(invitee: Student.find_by(email: invitee), inviter: Student.find_by(email:inviter), group: group).email_sent.deliver_now
        flash[:success] = 'Invite sent!'

        redirect_to new_invite_path
    else
      flash[:error] = 'Error: please enter a valid email address.'
      redirect_to new_invite_path
    end

  end


end