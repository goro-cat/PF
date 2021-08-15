Rails.application.routes.draw do

  get 'chats/index'
  get 'chats/show'
  get 'genres/new'
  get 'genres/edit'
  root to: 'homes#top'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update] do
    member do
      get :follower, :followed_user
    end
    #resource :relationships, only: [:create, :destroy]
    #get 'followings' => 'relationships#followings', as: 'followings'
    #get 'followers' => 'relationships#fllowers', as: 'followers'
    resources :chats
  end
  get 'follow/index' => 'relationships#index', as: 'follows'
  post 'follow/:id' => 'relationships#create', as: 'follow'
  post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'

  resources :posts

end
