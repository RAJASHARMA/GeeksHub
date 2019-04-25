Rails.application.routes.draw do

  root "articles#index"
  
  post '/rate' => 'rater#create', :as => 'rate'
  get '/articles/user_articles' => 'articles#user_articles'
  get '/articles/article_list' => 'articles#article_list'
  get '/articles/modify_status' => 'articles#modify_status'
  post '/articles/execute_code' => 'articles#execute_code'
  get 'profiles/rank' => 'profiles#rank'
  
  # resources :executions do
  #   get :execute_code, on: :collection 
  # end 
  
  mount Ckeditor::Engine => '/ckeditor'
  get 'tags/:tag', to: 'articles#index', as: :tag
  resources :articles do
    resources :comments
  end
  resources :tags
  resources :profiles

  devise_for :users  do
	 get '/users' => 'devise/registrations#create'
  end
	  
end
