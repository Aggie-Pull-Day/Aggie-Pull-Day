# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    if User.where(email: 'KareemH@tamu.edu').empty?
      User.create(email: 'KareemH@tamu.edu', password_digest: BCrypt::Password.create('Dummy'))
    end
    User.create(email: 'BaldwinB@tamu.edu', password_digest: 'Dummy') if User.where(email: 'BaldwinB@tamu.edu').empty?
    User.create(email: 'KareemH@tamu.edu', password_digest: 'Dummy') if User.where(email: 'ReidN@tamu.edu').empty?
    User.create(email: 'KareemH@tamu.edu', password_digest: 'Dummy') if User.where(email: 'JonW@tamu.edu').empty?
  end

  describe 'model' do
    it 'has the correct amount of data' do
      expect(User.all.length).to eq 4
    end

    it 'loads users based on a single attribute' do
      unencrypted = User.where(password_digest: 'Dummy')
      expect(unencrypted.length).to eq 3
    end

    it 'loads users based on multiple attributes' do
      reid_unencrypted = User.where(email: 'Reid Neason', password_digest: 'false')
      expect(reid_unencrypted.length).to eq 1
    end
  end

  describe 'welcome' do
    it '' do
    end
  end

  describe 'hasPulled' do
  end

  describe 'getTeam' do
  end

  describe 'Pull' do
  end
end

