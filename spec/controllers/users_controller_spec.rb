# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before :each do
    session[:user_id] = User.first.id
  end

  describe 'model' do
    it 'shows a group' do
      get :show, params: { id: 1 }
      expect(assigns(:user)).to eq User.first
    end

    it 'indexes groups' do
      get :index
      expect(assigns(:users)).to eq User.all
    end

    it 'makes a new user' do
      get :new
      expect(assigns(:user)[:pulled]).to be_falsey
    end

    it 'creates a new user' do
      post :create,
           params: { user: { uin: 2, pulled: false, group_id: nil, admin: false } }
      expect(response).to redirect_to User.last
    end

    it 'catches an invalid user creation' do
      post :create, params: { user: { uin: 1 } }
      expect(flash[:error]).to match(/^Error- please try to create an account again.$/)
      expect(response).to redirect_to '/users/new'
    end

    it 'edits a user' do
      get :edit, params: { id: 1 }
      expect(assigns(:user)).to eq User.first
    end

    it 'updates a user with valid parameters' do
      get :update, params: { id: 1, user: { group_id: 3, admin: true } }
      expect(response).to redirect_to User.first
      expect(flash[:notice]).to match /^User was successfully updated.$/
    end

    xit 'catches an invalid update' do
      get :update, params: { id: 2, user: { uin: 1 } }
      expect(response).to have_status :unprocessable_entity
    end

    xit 'destroys a group' do
      get :edit, params: { id: 1 }
      get :destroy
      expect(flash[:notice]).to match /^User was successfully destroyed.$/
      expect(response).to redirect_to '/users'
    end
  end

  describe 'reassign_group_ownership' do
    it 'reassigns to the proper user' do
      get :reassign_group_ownership, params: { id: 4 }
      expect(Group.first.owner).to eq 'Baldwin Bakkal'
      expect(Group.first.email).to eq 'bbakkal97@tamu.edu'
      expect(response).to redirect_to User.first
    end
  end

  describe 'leave_group' do
    it 'removes the current user from their group' do
      patch :leave_group, params: { id: User.first[:id] }
      expect(User.first[:group_id]).to be_nil
    end
  end

  describe 'update_pull_status' do
    xit 'follows through' do
      expect do
        get :update_pull_status, params: { success: 1, already_pulled: 0 }
      end.to output('data updated').to_stdout
    end
  end

  describe 'displayqr' do
    it 'uses the correct user' do
      get :displayqr, params: { id: 1 }
      expect(assigns(:user)).to eq User.first
    end

    it 'displays a QR code' do
      get :displayqr, params: { id: 1 }
      expect(assigns(:qr)).to be_a(RQRCode::QRCode)
    end
  end

  describe 'remove_from_group' do
    it 'removes the chosen user from their group' do
      patch :remove_from_group, params: { id: User.last[:id] }
      expect(User.last[:group_id]).to be_nil
    end
  end

  describe 'join_group' do
    it 'assigns the proper user' do
      get :join_group, params: { id: 4 }
      expect(assigns(:user)).to eq User.find(4)
    end
  end

  describe 'add_to_group' do
    it 'successfully adds the user with an invite' do
      Invite.create!(group_id: 3, inviter: 'matthewwaterman@tamu.edu', invitee: 'bbakkal97@tamu.edu')
      get :add_to_group, params: { id: 4, code: '113' }
      expect(User.find(4)[:group_id]).to eq 3
      expect(response).to redirect_to User.find(4)
    end

    it 'catches an invalid code' do
      get :add_to_group, params: { id: 1, code: '1784' }
      expect(flash[:error]).to match /^Error: please enter a valid group code.$/
    end

    it 'rejects a user without an invite' do
      get :add_to_group, params: { id: 2, code: '113' }
      expect(flash[:error]).to match /^You are not invited to this group. Please contact the group administrator if you have any questions.$/
      expect(response).to redirect_to join_group_path(User.find(2))
    end
  end

  before :all do
    ActionController::Base.allow_forgery_protection = false
  end
end
