# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'model' do
    it 'has the correct amount of data' do
      expect(Group.all.length).to eq 3
    end

    it 'loads groups based on a single attribute' do
      not_pulled = Group.where(pulled: false)
      expect(not_pulled.length).to eq 3
    end

    it 'loads groups based on multiple attributes' do
      team_1_not_pulled = Group.where(groupname: 'Team 1', pulled: false)
      expect(team_1_not_pulled.length).to eq 1
    end

    it 'updates a single attribute of a group' do
      Group.first.update(groupname: 'Team 2')
      expect(Group.where(groupname: 'List Eaters').length).to eq 0
      expect(Group.where(groupname: 'Team 2').length).to eq 1
    end

    it 'updates multiple attributes of a group' do
      Group.first.update(groupname: 'Team 2', owner: 'Jon Waterman')
      expect(Group.where(groupname: 'List Eaters').length).to eq 0
      expect(Group.where(groupname: 'Team 2').length).to eq 1
      expect(Group.where(owner: 'Kareem Hirani').length).to eq 0
      expect(Group.where(owner: 'Jon Waterman').length).to eq 1
    end

    it 'deletes groups based on a single attribute' do
      Group.create(groupname: 'The Professors', owner: 'Philip Ritchey', email: 'PhilipR@tamu.edu', pulled: false)
      expect(Group.all.length).to eq 4
      Group.where(groupname: 'The Professors').destroy_all
      expect(Group.all.length).to eq 3
    end

    it 'deletes groups based on multiple attributes' do
      Group.create(groupname: 'The Professors', owner: 'Philip Ritchey', email: 'PhilipR@tamu.edu', pulled: false)
      expect(Group.all.length).to eq 4
      Group.where(groupname: 'The Professors', owner: 'Philip Ritchey').destroy_all
      expect(Group.all.length).to eq 3
    end

    it 'refuses to delete an occupied group' do
      expect { Group.where(groupname: 'List Eaters').destroy_all }.to raise_error(ActiveRecord::InvalidForeignKey)
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
      group = Group.create(groupname: 'The Professors', pulled: false, owner: 'Philip Ritchey',
                           email: 'PhilipR@tamu.edu')
      User.create(email: 'PhilipR@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U4',
                  group_id: group.id)
      User.create(email: 'RobertL@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U3',
                  group_id: group.id)
      User.create(email: 'IoannisP@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U2',
                  group_id: group.id)
      User.create(email: 'YannisK@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U1',
                  group_id: group.id)
      expect(group.classification).to eq 'U1'
    end

    it 'properly cascades to a middle case' do
      group = Group.create(groupname: 'The Professors', pulled: false, owner: 'Philip Ritchey',
                           email: 'PhilipR@tamu.edu')
      User.create(email: 'PhilipR@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U4',
                  group_id: group.id)
      User.create(email: 'RobertL@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U2',
                  group_id: group.id)
      User.create(email: 'IoannisP@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U2',
                  group_id: group.id)
      User.create(email: 'YannisK@tamu.edu', password_digest: BCrypt::Password.create('Dummy'), classification: 'U1',
                  group_id: group.id)
      expect(group.classification).to eq 'U2'
    end
  end

  describe 'dropdown_options' do
    it 'returns the proper list' do
      group = Group.first
      opts = group.dropdown_options
      expect(opts.length).to eq 4
      expect(opts).to eq [%w[kareemh17@tamu.edu kareemh17@tamu.edu], %w[bbakkal97@tamu.edu bbakkal97@tamu.edu],
                          %w[jonrwaterman@tamu.edu jonrwaterman@tamu.edu], %w[reidneason@tamu.edu reidneason@tamu.edu]]
    end
  end
end

