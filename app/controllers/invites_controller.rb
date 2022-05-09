class InvitesController < ApplicationController

  def new
  end

  def create
    invitee = params[:email]
    inviter = User.find(session[:user_id]).get_email
    group_id = User.find(session[:user_id]).group_id
    inviter_accepted = true
    inviter_accepted = true

    Invite.create(group_id: group_id, inviter: inviter, invitee: invitee, inviter_accepted: true, invitee_accepted: false)

    # call method to send an invite here
    group = Group.where(id: group_id)
    InviteMailer.with(user_email: invitee, id: group.code).email_sent.deliver_now
    redirect_to new_invite_path

  end

  def send_invite
  end

end