Rails.application.routes.draw do
  root 'home#index'

  get 'admin_login/' => 'admin_login#index'
  post 'admin_login/login' => 'admin_login#login'
  post 'admin_login/logout' => 'admin_login#logout'

  namespace :manage do
    get :table_list
    get :column_list
  end

  resources :shops do
    patch 'delete', :on => :member
  end

  resources :tips do
    patch 'delete', :on => :member
  end

  resources :tip_genres

  resources :contacts

  resources :genre_tags
end
