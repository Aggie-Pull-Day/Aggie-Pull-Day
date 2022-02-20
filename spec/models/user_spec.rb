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

  describe 'model' do
    xit 'has the correct amount of data' do
      expect(User.all.length).to eq 4
    end

    xit 'loads users based on a single attribute' do
      unencrypted = User.where(password_digest: 'Dummy')
      expect(unencrypted.length).to eq 3
    end

    xit 'loads users based on multiple attributes' do
      reid_unencrypted = User.where(email: 'ReidN@tamu.edu', password_digest: false)
      expect(reid_unencrypted.length).to eq 1
    end

    xit 'deletes users based on a single attribute' do
      Users.where(email: 'ReidN@tamu.edu').destroy_all
      expect(User.all.length).to eq 3
    end

    xit 'deletes users based on multiple attributes' do
      Users.where(email: 'BaldwinB@tamu.edu', password_digest: 'Dummy').destroy_all
      expect User.all.length to eq 2
    end
  end

  describe 'welcome' do
    let(:user) do
      User.create(email: 'PhilipR@tamu.edu', password: 'OldArmy')
    end

    xit 'returns the proper message' do
      expect(user.welcome).to eq 'Hello, PhilipR@tamu.edu!'
    end
  end

  describe 'hasPulled' do
    let(:user) do
      User.create(email: 'PhilipR@tamu.edu', password: 'OldArmy')
    end
  end

  describe 'getTeam' do
  end

  describe 'Pull' do
  end
end

