# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  before :each do
    session[:user_id] = User.first.id
  end

  describe 'controller' do
    it 'indexes correctly' do
      get :index
      assert_response 200
    end

    it 'creates a new game' do
      post :create, params: { game: { opponent: 'LSU', gamedate: '26-Nov-2022' } }
      expect(response).to redirect_to Game.last
      expect(flash[:notice]).to match(/^Game was successfully created.$/)
      Game.find_by(opponent: 'LSU').destroy
    end

    it 'updates one attribute of an existing game' do
      game = Game.create(opponent: 'LSU', gamedate: '26-Nov-2022')
      put :update, params: { id: game.id, game: { opponent: 'UMass' } }
      expect(response).to redirect_to game_path(game)
      expect(flash[:notice]).to match(/^Game was successfully updated.$/)
      game.destroy
    end

    it 'updates multiple attributes of an existing game' do
      game = Game.create(opponent: 'LSU', gamedate: '26-Nov-2022')
      put :update, params: { id: game.id, game: { opponent: 'UMass', gamedate: '19-Nov-2022' } }
      expect(response).to redirect_to game_path(game)
      expect(flash[:notice]).to match(/^Game was successfully updated.$/)
      game.destroy
    end

    it 'destroys a game' do
      game = Game.create(opponent: 'LSU', gamedate: '26-Nov-2022')
      delete :destroy, params: { id: game.id }
      expect(flash[:notice]).to match(/^Game was successfully destroyed.$/)
    end
  end
end
