# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'model' do
    it 'has the correct amount of data' do
      expect(User.all.length).to eq 8
    end

    it 'loads users based on a single attribute' do
      unencrypted = User.where(password_digest: 'Dummy')
      expect(unencrypted.length).to eq 6
    end

    it 'loads users based on multiple attributes' do
      reid_unencrypted = User.where(email: 'ReidN@tamu.edu', password_digest: 'Dummy')
      expect(reid_unencrypted.length).to eq 1
    end

    it 'deletes users based on a single attribute' do
      User.where(email: 'ReidN@tamu.edu').destroy_all
      expect(User.all.length).to eq 7
    end

    it 'deletes users based on multiple attributes' do
      User.where(email: 'BaldwinB@tamu.edu', password_digest: 'Dummy').destroy_all
      expect(User.all.length).to eq 7
    end
  end

  describe 'welcome' do
    it 'returns the proper message' do
      user = User.where(email: 'ReidN@tamu.edu').first
      expect(user.welcome).to eq 'Hello, ReidN@tamu.edu!'
    end
  end

  describe 'hasPulled' do
    it 'returns the proper status' do
      user = User.where(email: 'ReidN@tamu.edu').first
      expect(user.hasPulled).to eq false
    end
  end

  describe 'getTeam' do
  end

  describe 'Pull' do
    it 'pulls for the group member' do
      user = User.where(email: 'ReidN@tamu.edu').first
      user.Pull
      group = Group.where(id: user['group_id']).first
      expect(group.pulled).to eq true
    end
  end

  describe 'pullTime' do
    it 'returns the correct pull time' do
      user = User.where(email: 'ReidN@tamu.edu').first
      pulltime = user.pullTime
      expect(pulltime).to eq Time.new(2022, 8, 29, 0, 0, 0)
    end
  end
end

