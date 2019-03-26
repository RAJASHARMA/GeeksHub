Rails.application.routes.draw do
  root "articles#index"
  post '/rate' => 'rater#create', :as => 'rate'
  mount Ckeditor::Engine => '/ckeditor'
  get 'tags/:tag', to: 'articles#index', as: :tag
  resources :articles do
    resources :comments
  end
  devise_for :users 

  devise_scope :user do
    delete '/users/sign_out' => 'devise/sessions#destroy'
  end
end
