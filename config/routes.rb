Rails.application.routes.draw do

  root "articles#index"
  
  post '/rate' => 'rater#create', :as => 'rate'
  get '/articles/user_articles' => 'articles#user_articles'
  get '/articles/article_list' => 'articles#article_list'
  get '/articles/modify_status' => 'articles#modify_status'
  get 'profiles/rank' => 'profiles#rank'
  
  mount Ckeditor::Engine => '/ckeditor'
  get 'tags/:tag', to: 'articles#index', as: :tag
  resources :articles do
    resources :comments
  end
  
  resources :profiles

  devise_for :users  do
	 get '/users' => 'devise/registrations#create'
  end
	  
end
