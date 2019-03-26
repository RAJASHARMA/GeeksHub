Rails.application.routes.draw do
  root "articles#index"
  post '/rate' => 'rater#create', :as => 'rate'
  mount Ckeditor::Engine => '/ckeditor'

  resources :articles do
    resources :comments
  end
  devise_for :users
end
