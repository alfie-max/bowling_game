Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :games do
        resources :frames, param: :frame_number, only: %i[create update]
      end
    end
  end
end
