# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Group, type: :model do
  before :all do
    if Group.where(member: 'Kareem Hirani').empty?
      Group.create(groupname: "Kareem's Group", member: 'Kareem Hirani', pulled: 'false')
    end
    if Group.where(member: 'Baldwin Bakkal').empty?
      Group.create(groupname: "Baldwin's Group", member: 'Baldwin Bakkal', pulled: 'false')
    end
    if Group.where(member: 'Reid Neason').empty?
      Group.create(groupname: "Reid's Group", member: 'Reid Neason', pulled: 'false')
    end
    if Group.where(member: 'Jon Waterman').empty?
      Group.create(groupname: "Jon's Group", member: 'Jon Waterman', pulled: 'false')
    end
  end

  describe 'model' do
    it 'has the correct amount of data' do
      expect(Group.all.length).to eq 4
    end

    it 'loads groups based on a single attribute' do
      not_pulled = Group.where(pulled: 'false')
      expect(not_pulled.length).to eq 4
    end

    it 'loads groups based on multiple attributes' do
      reid_not_pulled = Group.where(member: 'Reid Neason', pulled: 'false')
      expect(reid_not_pulled.length).to eq 1
    end

    it 'deletes groups based on a single attribute' do
      Group.where(groupname: "Jon's Group").destroy_all
      expect(Group.all.length).to eq 3
    end

    it 'deletes groups based on multiple attributes' do
      Group.where(groupname: "Kareem's Group", pulled: false).destroy_all
      expect(Group.all.length).to eq 2
    end
  end
end

