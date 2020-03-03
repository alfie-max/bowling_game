require 'rails_helper'

RSpec.describe 'Games Controller', type: :request do
  let!(:games) { create_list(:game, 20) }
  let(:game_id) { games.sample.id }

  describe 'GET /api/v1/games' do
    before { get api_v1_games_path }

    it 'returns all games present' do
      expect(json_body).not_to be_empty
      expect(json_body.size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/games' do
    let(:valid_attributes) { { game: { player_name: 'Joey Tribbiani' } } }

    context 'when the request is valid' do
      before { post api_v1_games_path, params: valid_attributes }

      it 'creates a game with player name' do
        expect(json_body['player_name']).to eq('Joey Tribbiani')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    let(:invalid_attributes) { { game: { player_name: nil } } }

    context 'when request is invalid' do
      before { post api_v1_games_path, params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json_body['message']).to match(/Validation failed/)
      end
    end
  end

  describe 'GET /api/v1/games/:id' do
    before { get api_v1_game_path(game_id) }

    context 'for existing game' do
      it 'returns the game details' do
        expect(json_body).not_to be_empty
        expect(json_body['id']).to eq(game_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'for game which does not exist' do
      let(:game_id) { rand(1000) }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json_body['message']).to match(/Couldn't find Game/)
      end
    end
  end

  describe 'PUT /api/v1/games/:id' do
    let(:valid_attributes) { { game: { player_name: 'Monica Geller' } } }
    before { put api_v1_game_path(game_id), params: valid_attributes }

    context 'when the record exists' do

      it 'updates player name for existing game' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /api/v1/games/:id' do
    before { delete api_v1_game_path(game_id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
