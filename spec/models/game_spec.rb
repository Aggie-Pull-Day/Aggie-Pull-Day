# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
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

    it 'updates one attribute of a game' do
      Game.first.update(opponent: 'tu')
      expect(Game.where(opponent: 'tu').length).to eq 1
      expect(Game.where(opponent: 'Sam Houston State').length).to eq 0
    end

    it 'updates multiple attributes of a game' do
      Game.first.update(opponent: 'tu', day: 'Friday')
      expect(Game.where(opponent: 'tu').length).to eq 1
      expect(Game.where(day: 'Friday').length).to eq 1
      expect(Game.where(opponent: 'Sam Houston State').length).to eq 0
      expect(Game.where(day: 'Saturday').length).to eq 1
    end

    it 'deletes games based on a single attribute' do
      Game.where(day: 'Thursday').destroy_all
      expect(Game.all.length).to eq 2
    end

    it 'deletes games based on multiple attributes' do
      Game.where(hometeam: 'TAMU', day: 'Saturday').destroy_all
      expect(Game.all.length).to eq 1
    end
  end
end
