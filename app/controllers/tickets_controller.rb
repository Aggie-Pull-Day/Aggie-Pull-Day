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
    team = User.where(group_id: group_id)

    @team.each do |member|
      if Ticket.where(:uin => member.uin).blank?
        ticket = Ticket.create()
        ticket.update(:uin => member.uin, :seat_assignment => SecureRandom.urlsafe_base64(5))
        flash[:result] = "Tickets have been successfully pulled."
        success << member.uin

        # make a new API call for this
        User.find_by(uin: member.uin).update(pulled: true)
        QrMailer.with(user: member).email_sent.deliver_now
        
      else
        already_pulled << member.uin
      end
    end


    require "uri"
    require "net/http"

    params = {'success' => success.join(','), 'already_pulled' => already_pulled.join(',')}
    
    # UNCOMMENT BELOW IF ON PRODUCTION
    x = Net::HTTP.post_form(URI.parse('http://list-eaters.herokuapp.com/users/update_pull_status'), params)
    # UNCOMMENT BELOW IF ON DEV
    # x = Net::HTTP.post_form(URI.parse('http://localhost:3000/users/update_pull_status'), params)

    redirect_to pull_list_path(id: group_id)
    
  end

  def assign_seat
  end
end