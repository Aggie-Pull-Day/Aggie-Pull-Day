# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'model' do
    it 'has the correct amount of data' do
      expect(User.all.length).to eq 9
    end

    it 'loads users based on a single attribute' do
      list_eaters = User.where(group_id: 1)
      expect(list_eaters.length).to eq 4
    end

    it 'loads users based on multiple attributes' do
      reid_list_eaters = User.where(email: 'reidneason@tamu.edu', group_id: 1)
      expect(reid_list_eaters.length).to eq 1
    end

    it 'updates one attribute of a user' do
      User.first.update(classification: 'U3')
      expect(User.where(classification: 'U4').length).to eq 6
      expect(User.where(classification: 'U3').length).to eq 1
    end

    it 'updates multiple attributes of a user' do
      User.first.update(classification: 'U3', email: 'kareemhirani@listeaters.com')
      expect(User.where(classification: 'U4').length).to eq 6
      expect(User.where(classification: 'U3').length).to eq 1
      expect(User.where(email: 'kareemhirani@listeaters.com').length).to eq 1
      expect(User.where(email: 'kareemh17@tamu.edu').length).to eq 0
    end

    it 'deletes users based on a single attribute' do
      User.where(email: 'reidneason@tamu.edu').destroy_all
      expect(User.all.length).to eq 8
    end

    it 'deletes users based on multiple attributes' do
      User.where(email: 'bbakkal97@tamu.edu', group_id: 1).destroy_all
      expect(User.all.length).to eq 8
    end
  end

  describe 'welcome' do
    it 'returns the proper message' do
      user = User.first
      expect(user.welcome).to eq 'Hello, kareemh17@tamu.edu!'
    end
  end

  describe 'hasPulled' do
    it 'returns the proper status' do
      user = User.first
      expect(user.hasPulled).to eq false
    end
  end

  describe 'getTeam' do
    it 'returns all members of a group' do
      user = User.first
      expect(user.getTeam.length).to eq 4
    end

    it 'returns properly for a user without a group' do
      user = User.create(email: 'PhilipR@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                         classification: 'U4')
      expect(user.getTeam.length).to eq 0
    end
  end

  describe 'Pull' do
    it 'queues an email to be sent' do
      expect do
        User.first.Pull
      end.to have_enqueued_job.on_queue('mailers').exactly(:once)
    end
  end

  describe 'pullTime' do
    it 'returns the correct pull time' do
      user = User.first
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
      user = User.where(email: 'kareemh17@tamu.edu').first
      expect(user.group_owner?).to eq true
    end

    it 'properly denies a non-owner' do
      user = User.where(email: 'reidneason@tamu.edu').first
      expect(user.group_owner?).to eq false
    end
  end

  describe 'dropdown_options' do
    it 'returns the proper list' do
      user = User.first
      opts = user.dropdown_options
      expect(opts.length).to eq 3
      expect(opts).to eq [['bbakkal97@tamu.edu', 2], ['jonrwaterman@tamu.edu', 3], ['reidneason@tamu.edu', 4]]
    end
  end
end

