# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  describe 'controller' do
    it 'creates a new group' do
      get :create, params: { group: { groupname: "Philip's Group", member: 'Philip Ritchey', pulled: 'false' } }
      expect(flash[:notice]).to match(/^Group was successfully created.$/)
      Group.find_by(member: 'Philip Ritchey').destroy
    end

    it 'updates one attribute of an existing group' do
      group = Group.create(groupname: "Philip's Group", member: 'Philip Ritchey', pulled: 'false')
      get :update, params: { id: group.id, group: { groupname: 'The Professors' } }
      expect(response).to redirect_to group_path(group)
      expect(flash[:notice]).to match(/^Group was successfully updated.$/)
      group.destroy
    end

    it 'updates multiple attributes of an existing group' do
      group = Group.create(groupname: "Philip's Group", member: 'Philip Ritchey', pulled: 'false')
      get :update, params: { id: group.id, group: { groupname: 'The Professors', member: 'Robert Lightfoot' } }
      expect(response).to redirect_to group_path(group)
      expect(flash[:notice]).to match(/^Group was successfully updated.$/)
      group.destroy
    end
  end
end

