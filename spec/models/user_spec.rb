# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    if User.where(email: 'KareemH@tamu.edu').empty?
      User.create(email: 'KareemH@tamu.edu', password_digest: BCrypt::Password.create('Dummy'))
    end
    User.create(email: 'BaldwinB@tamu.edu', password_digest: 'Dummy') if User.where(email: 'BaldwinB@tamu.edu').empty?
    User.create(email: 'ReidN@tamu.edu', password_digest: 'Dummy') if User.where(email: 'ReidN@tamu.edu').empty?
    User.create(email: 'JonW@tamu.edu', password_digest: 'Dummy') if User.where(email: 'JonW@tamu.edu').empty?
  end

  describe 'model', pending: true do
    it 'has the correct amount of data' do
      expect(User.all.length).to eq 4
    end

    it 'loads users based on a single attribute' do
      unencrypted = User.where(password_digest: 'Dummy')
      expect(unencrypted.length).to eq 3
    end

    it 'loads users based on multiple attributes' do
      reid_unencrypted = User.where(email: 'ReidN@tamu.edu', password_digest: false)
      expect(reid_unencrypted.length).to eq 1
    end

    it 'deletes users based on a single attribute' do
      Users.where(email: 'ReidN@tamu.edu').destroy_all
      expect(User.all.length).to eq 3
    end

    it 'deletes users based on multiple attributes' do
      Users.where(email: 'BaldwinB@tamu.edu', password_digest: 'Dummy').destroy_all
      expect User.all.length to eq 2
    end
  end

  describe 'welcome' do
    let(:user) do
      User.create(email: 'PhilipR@tamu.edu', password: 'OldArmy')
    end

    it 'returns the proper message' do
      expect(user.welcome).to eq 'Hello, PhilipR@tamu.edu!'
    end
  end

  describe 'hasPulled', pending: true do
    let(:user) do
      User.create(email: 'PhilipR@tamu.edu', password: 'OldArmy')
    end
    let(:group) do
      Group.create(groupname: 'The Professors', member: 'Philip Ritchey', pulled: false, email: 'PhilipR@tamu.edu')
      Group.create(groupname: 'The Professors', member: 'Robert Lightfoot', pulled: false, email: 'RobertL@tamu.edu')
    end

    it 'returns the proper status' do
      expect(user.hasPulled).to eq false
    end
  end

  describe 'getTeam', pending: true do
  end

  describe 'Pull', pending: true do
    let(:user) do
      User.create(email: 'RobertL@tamu.edu', password: 'OldArmy')
    end
    let(:group) do
      Group.create(groupname: 'The Professors', member: 'Philip Ritchey', pulled: false, email: 'PhilipR@tamu.edu')
      Group.create(groupname: 'The Professors', member: 'Robert Lightfoot', pulled: false, email: 'RobertL@tamu.edu')
    end

    it 'pulls for the group member' do
      user.Pull
      expect(Group.where(email: user.email).pulled).to eq true
    end
  end
end

