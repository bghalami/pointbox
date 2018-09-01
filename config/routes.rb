Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homepage#show'

  resource :users, except: [:edit] do
    resource :dashboard, only: [:show]
  end
  get '/users/edit/:id', to: 'users#edit', as: :edit_users
  put '/user_profile/:id', to: 'users#update', as: :update_users

  resource :admin, only: [:show]

  get '/user_profile/:id', to: 'users#adminshow', as: :user_profile

  get '/all_users'     => 'users#index'

  get '/login'     => 'sessions#new'
	# create (post) action for when log in form is submitted:
	post '/login'    => 'sessions#create'
	# delete action to log out:
	delete '/logout' => 'sessions#destroy'

end
