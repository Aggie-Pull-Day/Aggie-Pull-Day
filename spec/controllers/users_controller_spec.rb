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

  describe 'leave_group' do
    it 'removes the current user from their group' do
      patch :leave_group, params: { id: User.first[:id] }
      expect(User.first[:group_id]).to be_nil
    end
  end

  describe 'remove_from_group' do
    it 'removes the chosen user from their group' do
      patch :remove_from_group, params: { id: User.last[:id] }
      expect(User.last[:group_id]).to be_nil
    end
  end

  before :all do
    ActionController::Base.allow_forgery_protection = false
  end
end
