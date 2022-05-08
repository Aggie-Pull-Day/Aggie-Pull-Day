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
      list_eaters_not_pulled = User.where(pulled: false, group_id: 1)
      expect(list_eaters_not_pulled.length).to eq 4
    end

    it 'updates one attribute of a user' do
      User.first.update(pulled: true)
      expect(User.where(pulled: false).length).to eq 8
      expect(User.where(pulled: true).length).to eq 1
    end

    it 'updates multiple attributes of a user' do
      User.first.update(pulled: true, group_id: nil)
      expect(User.where(pulled: false).length).to eq 8
      expect(User.where(pulled: true).length).to eq 1
      expect(User.where(group_id: nil).length).to eq 2
      expect(User.where.not(group_id: nil).length).to eq 7
    end

    it 'deletes users based on a single attribute' do
      User.where(group_id: 1).destroy_all
      expect(User.all.length).to eq 5
    end

    it 'deletes users based on multiple attributes' do
      User.where(group_id: 1, pulled: false).destroy_all
      expect(User.all.length).to eq 5
    end
  end

  describe 'welcome' do
    it 'returns the proper message' do
      user = User.first
      expect(user.welcome).to eq 'Hello, Kareem!'
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
      Student.create(uin: 2, email: 'PhilipR@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                     first_name: 'Philip', last_name: 'Ritchey', classification: 'U4')
      user = User.create(uin: 2, pulled: false, group_id: nil, admin: false)
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

    it 'properly cascades through cases' do
      group = Group.create(groupname: 'The Professors', pulled: false, owner: 'Philip Ritchey',
                           email: 'PhilipR@tamu.edu')
      Student.create(uin: 2, email: 'PhilipR@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                     first_name: 'Philip', last_name: 'Ritchey', classification: 'U4')
      Student.create(uin: 3, email: 'RobertL@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                     first_name: 'Robert', last_name: 'Lightfoot', classification: 'U3')
      Student.create(uin: 4, email: 'IoannisP@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                     first_name: 'Ioannis', last_name: 'Pazianas', classification: 'U3')
      Student.create(uin: 5, email: 'YannisK@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                     first_name: 'Yannis', last_name: 'Kiourtsoglou', classification: 'U1')
      User.create(uin: 2, pulled: false, group_id: group.id, admin: false)
      User.create(uin: 3, pulled: false, group_id: group.id, admin: false)
      User.create(uin: 4, pulled: false, group_id: group.id, admin: false)
      User.create(uin: 5, pulled: false, group_id: group.id, admin: false)
      expect(User.last.pullTime).to eq Time.new(2022, 8, 30, 8, 0, 0)
      Student.find_by(uin: 3).update(classification: 'U2')
      Student.find_by(uin: 4).update(classification: 'U2')
      expect(User.last.pullTime).to eq Time.new(2022, 8, 31, 8, 0, 0)
      Student.find_by(uin: 3).update(classification: 'U1')
      Student.find_by(uin: 4).update(classification: 'U1')
      expect(User.last.pullTime).to eq Time.new(2022, 9, 1, 8, 0, 0)
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
      user = User.find_by(uin: 327000000)
      expect(user.group_owner?).to eq true
    end

    it 'properly denies a non-owner' do
      user = User.where(uin: 327000002).first
      expect(user.group_owner?).to eq false
    end
  end

  describe 'full_name' do
    it 'returns a proper full name' do
      expect(User.first.full_name).to eq 'Kareem Hirani'
    end

    it 'returns a first name with no last name' do
      Student.create(uin: 2, email: 'PhilipR@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                     first_name: 'Philip', classification: 'U4')
      user = User.create(uin: 2, pulled: false, group_id: nil, admin: false)
      expect(user.full_name).to eq 'Philip'
    end

    it 'returns a last name with no first name' do
      Student.create(uin: 2, email: 'PhilipR@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                     last_name: 'Ritchey', classification: 'U4')
      user = User.create(uin: 2, pulled: false, group_id: nil, admin: false)
      expect(user.full_name).to eq 'Ritchey'
    end

    it 'returns anonymous user properly' do
      Student.create(uin: 2, email: 'PhilipR@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                     classification: 'U4')
      user = User.create(uin: 2, pulled: false, group_id: nil, admin: false)
      expect(user.full_name).to eq 'User 2'
    end
  end

  describe 'pull_group' do
    it 'returns the correct pull group' do
      user = User.first
      pullgroup = user.pull_group
      expect(pullgroup).to eq 'seniors'
    end

    it 'properly cascades through cases' do
      group = Group.create(groupname: 'The Professors', pulled: false, owner: 'Philip Ritchey',
                           email: 'PhilipR@tamu.edu')
      Student.create(uin: 2, email: 'PhilipR@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                     first_name: 'Philip', last_name: 'Ritchey', classification: 'U4')
      Student.create(uin: 3, email: 'RobertL@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                     first_name: 'Robert', last_name: 'Lightfoot', classification: 'U3')
      Student.create(uin: 4, email: 'IoannisP@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                     first_name: 'Ioannis', last_name: 'Pazianas', classification: 'U3')
      Student.create(uin: 5, email: 'YannisK@tamu.edu', password_digest: BCrypt::Password.create('Dummy'),
                     first_name: 'Yannis', last_name: 'Kiourtsoglou', classification: 'U1')
      User.create(uin: 2, pulled: false, group_id: group.id, admin: false)
      User.create(uin: 3, pulled: false, group_id: group.id, admin: false)
      User.create(uin: 4, pulled: false, group_id: group.id, admin: false)
      User.create(uin: 5, pulled: false, group_id: group.id, admin: false)
      expect(User.last.pull_group).to eq 'juniors'
      Student.find_by(uin: 3).update(classification: 'U2')
      Student.find_by(uin: 4).update(classification: 'U2')
      expect(User.last.pull_group).to eq 'sophomores'
      Student.find_by(uin: 3).update(classification: 'U1')
      Student.find_by(uin: 4).update(classification: 'U1')
      expect(User.last.pull_group).to eq 'freshmen'
    end
  end
end

