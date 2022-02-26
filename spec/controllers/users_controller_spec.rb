# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before :all do
    if User.where(email: 'KareemH@tamu.edu').empty?
      User.create(email: 'KareemH@tamu.edu', password_digest: BCrypt::Password.create('Dummy'))
    end
    User.create(email: 'BaldwinB@tamu.edu', password_digest: 'Dummy') if User.where(email: 'BaldwinB@tamu.edu').empty?
    User.create(email: 'ReidN@tamu.edu', password_digest: 'Dummy') if User.where(email: 'ReidN@tamu.edu').empty?
    User.create(email: 'JonW@tamu.edu', password_digest: 'Dummy') if User.where(email: 'JonW@tamu.edu').empty?
  end

  describe 'model', pending: true do
    it 'creates a new user' do
      get :create, params: { user: { email: 'CoraE@tamu.edu', password_digest: 'Team1' } }
    end
  end
end
