Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :favorites
    end

    resource :relationships, only: %i[create destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :chats, only: %i[index show create]

  resources :posts, only: %i[new show create destroy edit update] do
    resource :favorites, only: %i[index create destroy]
    resources :comments, only: %i[create destroy]
  end

  get 'retrieval' => 'posts#retrieval'

  get 'protect' => 'posts#protect'

  get 'search' => 'posts#search'
  # 通知
  resources :notifications, only: [:index]
  delete 'notifications/destroy' => 'notifications#destroy_all'
end
