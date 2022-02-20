# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  before :all do
    if Game.where(opponent: 'Sam Houston State').empty?
      Game.create(hometeam: 'TAMU', opponent: 'Sam Houston State', gamedate: '3-Sep-2022', day: 'Saturday')
    end
    if Game.where(opponent: 'App State').empty?
      Game.create(hometeam: 'TAMU', opponent: 'App State', gamedate: '10-Sep-2022', day: 'Saturday')
    end
    if Game.where(opponent: 'Miami (FL)').empty?
      Game.create(hometeam: 'TAMU', opponent: 'Miami (FL)', gamedate: '17-Sep-2022', day: 'Thursday')
    end
  end

  describe 'model' do
    it 'has the correct amount of data' do
      expect(Game.all.length).to eq 3
    end

    it 'loads games based on a single attribute' do
      saturday_games = Game.where(day: 'Saturday')
      expect(saturday_games.length).to eq 2
    end

    it 'loads games based on multiple attributes' do
      saturday_shsu_games = Game.where(opponent: 'Sam Houston State', day: 'Saturday')
      expect(saturday_shsu_games.length).to eq 1
    end

    it 'deletes games based on a single attribute' do
      Game.where(day: 'Thursday').destroy_all
      expect(Game.all.length).to eq 2
    end

    it 'deletes games based on multiple attributes' do
      Game.where(hometeam: 'TAMU', day: 'Saturday').destroy_all
      expect(Game.all.length).to eq 0
    end
  end
end
