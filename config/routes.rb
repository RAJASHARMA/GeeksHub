Rails.application.routes.draw do

  get 'report/create'

  root "articles#index"
  
  post '/rate' => 'rater#create', :as => 'rate'
  get '/articles/user_articles' => 'articles#user_articles'
  get '/articles/article_list' => 'articles#article_list'
  get '/articles/modify_status' => 'articles#modify_status'
  get '/profiles/rank' => 'profiles#rank'
  get '/pages/*page' => 'pages#show', :as => 'page_show'
  get 'profiles/rank_request' => 'profiles#rank_request'

  mount Ckeditor::Engine => '/ckeditor'
  get 'tags/:tag', to: 'articles#index', as: :tag
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
