# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'model' do
    it 'has the correct amount of data' do
      expect(Game.all.length).to eq 17
    end

    it 'loads games based on a single attribute' do
      saturday_games = Game.where(opponent: 'Miami (FL)')
      expect(saturday_games.length).to eq 1
    end

    it 'loads games based on multiple attributes' do
      saturday_shsu_games = Game.where(opponent: 'Sam Houston State', gamedate: '3-Sep-2022')
      expect(saturday_shsu_games.length).to eq 1
    end

    it 'updates one attribute of a game' do
      Game.first.update(opponent: 'tu')
      expect(Game.where(opponent: 'tu').length).to eq 1
      expect(Game.where(opponent: 'Kent State').length).to eq 0
    end

    it 'updates multiple attributes of a game' do
      Game.first.update(opponent: 'tu', gamedate: '3-Sep-2025')
      expect(Game.where(opponent: 'tu').length).to eq 1
      expect(Game.where(gamedate: '3-Sep-2025').length).to eq 1
      expect(Game.where(opponent: 'Kent State').length).to eq 0
      expect(Game.where(gamedate: '4-Sep-2021').length).to eq 0
    end

    it 'deletes games based on a single attribute' do
      Game.where(gamedate: '3-Sep-2022').destroy_all
      expect(Game.all.length).to eq 16
    end

    it 'deletes games based on multiple attributes' do
      Game.where(opponent: 'Sam Houston State', gamedate: '3-Sep-2022').destroy_all
      expect(Game.all.length).to eq 16
    end
  end
end
