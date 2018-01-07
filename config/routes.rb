Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"

  # ## #### ## ## ## ## ## ## ## ## ## ## ##
  # Devise
  #
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations'
    #omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    match '/users/sign_out' => 'devise/sessions#destroy', as: :destroy_user_session_path, via: [:get, :delete]
  end

  get 'sign_in', to: redirect('/users/sign_in')
  get 'sign_out', to: redirect('/users/sign_out')
  get 'sign_up', to: redirect('/users/sign_up')
  get 'edit_registration', to: redirect('/users/edit')

  get 'users', to: redirect("sign_up")

  # ## #### ## ## ## ## ## ## ## ## ## ## ##
  # Generic Routes
  #
  get 'home/index'
  get 'about', to: 'high_voltage/pages#show', id: 'about'
  get 'ajax', to: 'high_voltage/pages#show', id: 'ajax'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Routes for Api
  apipie
  namespace :api do
    resources :apis, only: [:index]
    resources :photographers, only: [:index, :show, :create, :update, :destroy] do
      resources :photographs, only: [:index]
    end
    resources :photographs, only: [:create, :index, :show]
    resources :attendees, only: [] do
      resources :photographs, only: [:index]
      member do
        put :revoke
      end
    end
    get "/generate_secret", to: "apis#generate_secret"
  end


  root to: "home#index"
end
