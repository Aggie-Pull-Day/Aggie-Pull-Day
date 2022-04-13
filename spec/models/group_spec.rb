# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'model' do
    it 'has the correct amount of data' do
      expect(Group.all.length).to eq 2
    end

    it 'loads groups based on a single attribute' do
      not_pulled = Group.where(pulled: 'false')
      expect(not_pulled.length).to eq 2
    end

    it 'loads groups based on multiple attributes' do
      reid_not_pulled = Group.where(groupname: 'Team 1', pulled: 'false')
      expect(reid_not_pulled.length).to eq 1
    end

    it 'deletes groups based on a single attribute' do
      Group.where(groupname: 'Team 1').destroy_all
      expect(Group.all.length).to eq 1
    end

    it 'deletes groups based on multiple attributes' do
      Group.where(groupname: 'List Eaters', game_id: '1').destroy_all
      expect(Group.all.length).to eq 1
    end
  end

  describe 'classification' do
    it 'returns the proper classification' do
      group = Group.where(groupname: 'List Eaters').first
      expect(group.classification).to eq 'U4'
      group = Group.where(groupname: 'Team 1').first
      expect(group.classification).to eq 'U4'
    end

    it 'properly cascades to the default case' do
      group = Group.create(groupname: 'The Professors', pulled: false, game_id: 1)
      User.create(email: 'PhilipR@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U4',
                  group_id: group.id, seat_id: nil)
      User.create(email: 'RobertL@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U3',
                  group_id: group.id, seat_id: nil)
      User.create(email: 'IoannisP@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U2',
                  group_id: group.id, seat_id: nil)
      User.create(email: 'YannisK@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U1',
                  group_id: group.id, seat_id: nil)
      expect(group.classification).to eq 'U1'
    end
  end
end

