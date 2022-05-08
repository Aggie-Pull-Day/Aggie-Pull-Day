class InvitesController < ApplicationController

  def new
  end

  def create_invite
    invitee = params[:email]
    inviter = User.find(session[:user_id]).get_email
    group_id = User.find(session[:user_id]).group_id
    inviter_accepted = true
    inviter_accepted = true

    Invite.create(group_id: group_id, inviter: inviter, invitee: invitee, inviter_accepted: true, invitee_accepted: false)

    # send_invite via email
  end

  def send_invite
  end

end