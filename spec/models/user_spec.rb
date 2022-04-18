# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'model' do
    it 'has the correct amount of data' do
      expect(User.all.length).to eq 7
    end

    it 'loads users based on a single attribute' do
      list_eaters = User.where(group_id: 1)
      expect(list_eaters.length).to eq 4
    end

    it 'loads users based on multiple attributes' do
      reid_list_eaters = User.where(email: 'reidneason@tamu.edu', group_id: 1)
      expect(reid_list_eaters.length).to eq 1
    end

    it 'deletes users based on a single attribute' do
      User.where(email: 'reidneason@tamu.edu').destroy_all
      expect(User.all.length).to eq 6
    end

    it 'deletes users based on multiple attributes' do
      User.where(email: 'BBakkal@tamu.edu', group_id: 1).destroy_all
      expect(User.all.length).to eq 6
    end
  end

  describe 'welcome' do
    it 'returns the proper message' do
      user = User.where(email: 'reidneason@tamu.edu').first
      expect(user.welcome).to eq 'Hello, reidneason@tamu.edu!'
    end
  end

  describe 'hasPulled' do
    it 'returns the proper status' do
      user = User.where(email: 'reidneason@tamu.edu').first
      expect(user.hasPulled).to eq false
    end
  end

  describe 'getTeam' do
    it 'returns all members of a group' do
      user = User.where(email: 'reidneason@tamu.edu').first
      expect(user.getTeam.length).to eq 4
    end

    it 'returns properly for a user without a group' do
      user = User.create(email: 'PhilipR@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                         classification: 'U4')
      expect(user.getTeam.length).to eq 0
    end
  end

  describe 'Pull' do
    it "prints members' emails" do
      user = User.where(email: 'reidneason@tamu.edu').first
      expect {
        user.Pull }.to output("Kareemh17@tamu.edu\nBBakkal@tamu.edu\nJonWaterman@tamu.edu\nreidneason@tamu.edu\n").to_stdout
    end

    xit 'emails the proper members' do
      user = User.where(email: 'reidneason@tamu.edu').first
      user.Pull
      expect(ActionMailer::Base.deliveries.count).to eq 4
      expect(ActionMailer::Base.deliveries[0].to).to include('Kareemh17@tamu.edu')
      expect(ActionMailer::Base.deliveries[1].to).to include('BBakkal@tamu.edu')
      expect(ActionMailer::Base.deliveries[2].to).to include('JonWaterman@tamu.edu')
      expect(ActionMailer::Base.deliveries[3].to).to include('reidneason@tamu.edu')
    end

    xit 'assigns the correct number of seats' do
      user = User.where(email: 'reidneason@tamu.edu').first
      user.Pull
      expect(Seat.where(assigned: false).length).to eq 36
    end
  end

  describe 'pullTime' do
    it 'returns the correct pull time' do
      user = User.where(email: 'reidneason@tamu.edu').first
      pulltime = user.pullTime
      expect(pulltime).to eq Time.new(2022, 8, 29, 8, 0, 0)
    end
  end

  describe 'next_opponent' do
    it 'returns the correct opponent' do
      expect(User.first.next_opponent).to eq 'Sam Houston State'
    end

    it 'returns nil when there are no games left' do
      Game.destroy_all
      expect(User.first.next_opponent).to be_nil
    end
  end

  describe 'group_owner?' do
    it 'properly identifies the group owner' do
      user = User.where(email: 'Kareemh17@tamu.edu').first
      expect(user.group_owner?).to eq true
    end

    it 'properly denies a non-owner' do
      user = User.where(email: 'reidneason@tamu.edu').first
      expect(user.group_owner?).to eq false
    end
  end
end

