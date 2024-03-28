# config/routes.rb
Rails.application.routes.draw do
  resources :applications, param: :id, only: [:show, :update,:create] do
    resources :chats, only: [:index, :show, :create, :update, :destroy] do
      resources :messages, only: [:index, :show, :create, :update, :destroy]do
      collection do
        get 'search'
      end
     end
    end
  end
end
