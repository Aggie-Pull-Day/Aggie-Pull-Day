# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  before :each do
    session[:user_id] = User.first.id
  end

  describe 'controller' do
    it 'has a functioning index' do
      get :index
      expect(assigns(:groups)).to eq Group.all
    end

    it 'makes a new group' do
      get :new
      expect(assigns(:group_id)).to be_nil
      expect(assigns(:groupname)).to be_nil
      expect(assigns(:owner)).to be_nil
      expect(assigns(:pulled)).to be_nil
      expect(assigns(:email)).to be_nil
      expect(assigns(:code)).to be_nil
    end

    it 'initiates the editing of a group' do
      get :edit, params: { id: 1 }
      expect(assigns(:group)).to eq Group.first
    end

    it 'creates a new group as admin' do
      session[:user_id] = User.find_by(uin: 1)[:id]
      get :create,
          params: { group: { groupname: "Philip's Group", pulled: false, owner: 'Philip Ritchey',
                             email: 'PhilipR@tamu.edu' } }
      expect(flash[:notice]).to match(/^Group was successfully created.$/)
      Group.find_by(groupname: "Philip's Group").destroy
    end

    it 'creates a new group as a student' do
      get :create,
          params: { group: { groupname: "Philip's Group", pulled: false, owner: 'Philip Ritchey',
                             email: 'PhilipR@tamu.edu' } }
      expect(response).to redirect_to User.find(session[:user_id])
    end

    it 'updates one attribute of an existing group' do
      group = Group.create(groupname: "Philip's Group", pulled: false, owner: 'Philip Ritchey',
                           email: 'PhilipR@tamu.edu')
      get :update, params: { id: group.id, group: { groupname: 'The Professors' } }
      expect(response).to redirect_to group_path(group)
      expect(flash[:notice]).to match(/^Group was successfully updated.$/)
      group.destroy
    end

    it 'updates multiple attributes of an existing group' do
      group = Group.create(groupname: "Philip's Group", pulled: false, owner: 'Philip Ritchey',
                           email: 'PhilipR@tamu.edu')
      get :update, params: { id: group.id, group: { groupname: 'The Professors', owner: 'Robert Lightfoot' } }
      expect(response).to redirect_to group_path(group)
      expect(flash[:notice]).to match(/^Group was successfully updated.$/)
      group.destroy
    end

    it 'destroys a group' do
      group = Group.create(groupname: "Philip's Group", pulled: false, owner: 'Philip Ritchey',
                           email: 'PhilipR@tamu.edu')
      get :destroy, params: { id: group.id }
      expect(flash[:notice]).to match(/^Group was successfully destroyed.$/)
    end
  end

  describe 'pull_list' do
    it 'returns the correct list of UINs' do
      get :pull_list, params: { id: User.first.id }
      expect(assigns(:group_uins)).to eq [327000000, 327000001, 327000002, 327000003]
    end
  end
end

