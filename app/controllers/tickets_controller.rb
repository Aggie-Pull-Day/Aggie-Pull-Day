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

    group_uins.each do |uin|
      if Ticket.where(:uin => uin).blank?
        ticket = Ticket.create()
        ticket.update(:uin => uin, :seat_assignment => SecureRandom.urlsafe_base64(5))
        flash[:result] = "Tickets have been successfully pulled."
        success << uin
        # make a new API call for this
        # User.find_by(uin: member.uin).update(pulled: true)
        
      else
        already_pulled << uin
      end
    end

    require "uri"
    require "net/http"

    params = {'success' => success.join(','), 'already_pulled' => already_pulled.join(',')}

    api_link = ""
    if ENV['RAILS_ENV'] == 'production'
      api_link = "http://list-eaters.herokuapp.com/users/update_pull_status"
    else
      api_link = "http://localhost:3000/users/update_pull_status"
    end
    
    Net::HTTP.post_form(URI.parse(api_link), params)

    redirect_to pull_list_path(id: group_id)
    
  end

  def assign_seat
  end
end