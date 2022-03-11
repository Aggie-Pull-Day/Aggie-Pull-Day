# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'model' do
    it 'creates a new user', pending: true do
      post :create, params: { user: { email: 'PhilipR@tamu.edu', password_digest: BCrypt::Password.create('OldArmy') } }
      expect(response).to redirect_to User.last
    end

    it 'catches an invalid user creation' do
      post :create, params: { user: { email: 'PhilipR@tamu.edu' } }
      expect(flash[:error]).to match(/^Error- please try to create an account again.$/)
      expect(response).to redirect_to '/users/new'
    end
  end

  before :all do
    ActionController::Base.allow_forgery_protection = false
  end
end