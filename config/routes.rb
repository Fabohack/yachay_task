Rails.application.routes.draw do

  resources :inpairments

  resources :states

  resources :goals

  resources :organizations

  resources :statistics

  #root to: 'visitors#index'
  #root to: 'statistics#show'
  root to: 'projects#index'

  devise_for :users
  resources :users

  # %w(open close suspended).each do |scope|
  #   get "projects/#{scope}" => "projects#index", scope: scope
  # end

  get "assigned_to_me/filter/:scope", :to => 'tasks#assigned_to_me', as: :filtered_tasks

  get "alltasks/filter/:scope", :to => 'tasks#alltasks', as: :All_tasks

  get "choose_user/filter/:scope", :to => 'users#choose_user', as: :filtered_users

  get "inpairments/filter/:scope", :to => 'inpairments#impairments', as: :filtered_impairments

  get "projects/filter/:scope" => "projects#index", as: :filtered_projects


  get "statistics/show", as: :show_statistics
  get "statistics/filter/:scope" => "statistics#index", as: :filtered_statistics


  resources :projects do
    resources :memberships
    resources :alignmentse
    resources :tasks do
      resources :inpairments
    end

  end
  
end
