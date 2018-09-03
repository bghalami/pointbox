Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homepage#show'

  resource :users, except: [:edit] do
    resource :dashboard, only: [:show, :update]
  end
  get '/users/edit/:id', to: 'users#edit', as: :edit_users
  put '/user_profile/:id', to: 'users#update', as: :update_users


  resource :admin, only: [:show]

  resources :rewards, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  get "/gamble", to: 'users#gamble', as: :gamblers

  get '/user_profile/:id', to: 'users#adminshow', as: :user_profile

  get '/rewards', to: 'rewards#adminindex', as: :admin_rewards

  get '/users/:user_id/reward/:id', to: 'users#buyreward', as: :users_buy_reward

  get '/enable_rewards/:id', to: 'rewards#enable', as: :enable_reward

  get '/disable_rewards/:id', to: 'rewards#disable', as: :disable_reward

  delete '/user_profile/:id' => 'users#destroy', as: :user_delete

  get '/all_users'     => 'users#index'

  get '/login'     => 'sessions#new'
	# create (post) action for when log in form is submitted:
	post '/login'    => 'sessions#create'
	# delete action to log out:
	delete '/logout' => 'sessions#destroy'

end
