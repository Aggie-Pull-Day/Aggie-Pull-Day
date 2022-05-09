class TicketsController < ApplicationController

  def index
  end

  def show
  end

  def new
    # @ticket = Ticket.new(:uin => 727001419, :seat_assignment => "123a")
  end

  def pull_tickets
    group_uins = params[:uins].split(",")
    group_id = params[:group_id]
    
    success = []
    already_pulled = []
    @group = User.where(group_id: group_id)

    @group.each do |member|
      if Ticket.where(:uin => member.uin).blank?
        ticket = Ticket.create()
        ticket.update(:uin => member.uin, :seat_assignment => SecureRandom.urlsafe_base64(5))
        flash[:result] = "Tickets have been successfully pulled."
        success << member.uin

        # make a new API call for this
        User.find_by(uin: member.uin).update(pulled: true)
        TicketMailer.with(user: member).email_sent.deliver_now
        
      else
        already_pulled << member.uin
      end
    end


    require "uri"
    require "net/http"

    params = {'success' => success.join(','), 'already_pulled' => already_pulled.join(',')}

    if ENV['RAILS_ENV'] == 'production'
      api_link = "https://list-eaters.herokuapp.com/groups/#{@user.group_id}/pull_list"
    else
      api_link = "https://localhost:3000/groups/#{@user.group_id}/pull_list"
    end
    
    x = Net::HTTP.post_form(URI.parse(api_link), params)

    redirect_to pull_list_path(id: group_id)
    
  end

  def assign_seat
  end
end