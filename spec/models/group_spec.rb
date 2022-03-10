# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'model' do
    it 'has the correct amount of data' do
      expect(Group.all.length).to eq 8
    end

    it 'loads groups based on a single attribute' do
      not_pulled = Group.where(pulled: 'false')
      expect(not_pulled.length).to eq 8
    end

    it 'loads groups based on multiple attributes' do
      reid_not_pulled = Group.where(member: 'Reid Neason', pulled: 'false')
      expect(reid_not_pulled.length).to eq 1
    end

    it 'deletes groups based on a single attribute' do
      Group.where(groupid: 1).destroy_all
      expect(Group.all.length).to eq 4
    end

    it 'deletes groups based on multiple attributes' do
      Group.where(groupid: 1, member: "Reid Neason").destroy_all
      expect(Group.all.length).to eq 7
    end
  end
end

