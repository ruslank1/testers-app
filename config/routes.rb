Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => "my_registrations"
    }, :path => 'auth', :path_names => {
    :sign_in => 'login', :sign_out => 'logout'
  }
  # resources :users do
  #   member do
  #     get 'send_profile_card'
  #   end
  # end
  resources :users

  devise_scope :user do
    authenticated :user do
      root 'users#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get '/about', to: 'users#about'
end
