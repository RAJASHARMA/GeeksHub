Rails.application.routes.draw do
  root "articles#index"

  get 'report/create'
  get 'tags/:tag', to: 'articles#index', as: :tag
  post '/rate' => 'rater#create', :as => 'rate'
  get '/articles/user_articles' => 'articles#user_articles'
  get '/articles/article_list' => 'articles#article_list'
  get '/articles/modify_status' => 'articles#modify_status'
  post '/articles/execute_code' => 'articles#execute_code'

  get '/profiles/rank' => 'profiles#rank'
  get 'profiles/rank_request' => 'profiles#rank_request'
  get '/pages/*page' => 'pages#show', :as => 'page_show'

  mount Ckeditor::Engine => '/ckeditor'
  
  resources :articles do
    resources :comments
    resources :reports
    get :autocomplete_article_title, :on => :collection
  end
  resources :tags
  resources :profiles

  devise_for :users  do
	  get '/users' => 'devise/registrations#create'
  end
	  
end
