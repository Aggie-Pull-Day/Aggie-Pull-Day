# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'model', pending: true do
    it 'creates a new user' do
      get :create, params: { user: { email: 'PhilipR@tamu.edu', password_digest: 'OldArmy' } }
    end
  end
end
