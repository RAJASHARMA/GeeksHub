Rails.application.routes.draw do

  root "articles#index"
  post '/rate' => 'rater#create', :as => 'rate'
  mount Ckeditor::Engine => '/ckeditor'
  get 'tags/:tag', to: 'articles#index', as: :tag
  resources :articles do
    resources :comments
  end
  resources :comments do
    resources :comments
  end
  # devise_for :users 

  # namespace :admin do
  # 	root 'articles#index'
  # 	resources :articles
  # 	resources :users

  # end

  devise_for :users  do
	get '/users' => 'devise/registrations#create'
	
  end
	  
end
