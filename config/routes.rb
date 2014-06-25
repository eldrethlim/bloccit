# config/routes.rb

Bloccit::Application.routes.draw do
  
  devise_for :users
  resources :users, only: [:update]
  
  resources :topics do
  	resources :posts, except: [:index] do
    get '/p-up-vote' => 'votes#p_up_vote', as: :p_up_vote
    get '/p-down-vote' => 'votes#p_down_vote', as: :p_down_vote
    resources :favourites, only: [:create, :destroy]
    end
  end

  resources :posts do
    resources :comments, except: [:index] do
    get '/c-up-vote' => 'votes#c_up_vote', as: :c_up_vote
    get '/c-down-vote' => 'votes#c_down_vote', as: :c_down_vote
    end
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
  
 end