# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'controller' do
    it 'creates a new game' do
      get :create, params: { game: { hometeam: 'TAMU', opponent: 'LSU', gamedate: '26-Nov-2022', day: 'Saturday' } }
      expect(flash[:notice]).to match(/^Game was successfully created.$/)
      Game.find_by(opponent: 'LSU').destroy
    end

    it 'updates one attribute of an existing game' do
      game = Game.create(hometeam: 'TAMU', opponent: 'LSU', gamedate: '26-Nov-2022', day: 'Saturday')
      get :update, params: { id: game.id, game: { opponent: 'UMass' } }
      expect(response).to redirect_to game_path(game)
      expect(flash[:notice]).to match(/^Game was successfully updated.$/)
      game.destroy
    end

    it 'updates multiple attributes of an existing game' do
      game = Game.create(hometeam: 'TAMU', opponent: 'LSU', gamedate: '26-Nov-2022', day: 'Saturday')
      get :update, params: { id: game.id, game: { opponent: 'UMass', gamedate: '19-Nov-2022' } }
      expect(response).to redirect_to game_path(game)
      expect(flash[:notice]).to match(/^Game was successfully updated.$/)
      game.destroy
    end
  end
end
