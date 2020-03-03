require 'rails_helper'

RSpec.describe 'Frames Controller', type: :request do
  let!(:game) { create(:game) }
  let(:game_id) { game.id }
  let(:frame_id) { 1 }

  describe 'POST /api/v1/games/:game_id/frames' do
    let(:valid_attributes) do
      {
        frame: {
          first_ball_score: 4,
          second_ball_score: 6,
          third_ball_score: 0
        }
      }
    end

    context 'when the request is valid' do
      before { post api_v1_game_frames_path(game_id), params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns correct frame number' do
        expect(json_body['frame_number']).to eq(1)
      end
    end
  end

  describe 'PUT /api/v1/games/:game_id/frames/:frame_number' do
    let(:valid_attributes) { { frame: { second_ball_score: 4 } } }

    let(:frame) do
      create(
        :frame,
        game: game,
        frame_number: 1,
        first_ball_score: 5,
        second_ball_score: 1
      )
    end

    context 'for existing record' do
      before { put api_v1_game_frame_path(game, frame.frame_number), params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the frame' do
        expect(frame.reload.second_ball_score).to eq(4)
      end
    end

    context 'when the frame does not exist' do
      before { put api_v1_game_frame_path(game, frame.frame_number + 1) }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Frame/)
      end
    end
  end
end
