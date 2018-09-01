Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homepage#show'

  resource :admin do
    resource :users, only: [:new, :create]
  end

  resource :dashboard, only: [:show]

  get '/login'     => 'sessions#new'

	# create (post) action for when log in form is submitted:
	post '/login'    => 'sessions#create'

	# delete action to log out:
	delete '/logout' => 'sessions#destroy'

end
