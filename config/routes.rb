Rails.application.routes.draw do

  root "articles#index"
  post '/rate' => 'rater#create', :as => 'rate'
  get '/articles/user_articles' => 'articles#user_articles'
  mount Ckeditor::Engine => '/ckeditor'
  get 'tags/:tag', to: 'articles#index', as: :tag
  resources :articles do
    resources :comments
  end
  
  


  devise_for :users  do
	 get '/users' => 'devise/registrations#create'
	
  end
	  
end
