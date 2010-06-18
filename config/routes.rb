ActionController::Routing::Routes.draw do |map|

  #,  :requirements => { :id => /[A-Z]{30}\d{5}/ }

  map.resources :user_sessions

  map.resources :courses
  #map.resources :subscriptions, :has_many => :reference_teachers
  #map.resources :users, :has_many => :subscriptions

  #map.resources :subscriptions, :has_many => :reference_teachers
  #map.resources :users, :has_many =>:reference_teachers, :through => :subscriptions

  map.resources :users, :has_many => :subscriptions

  map.resources :subscriptions do |subscription|
    subscription.resources :reference_teachers
  end

  map.resources :subscriptions
  map.root :controller => "home"

  #autenticacao de usuarios
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.connect 'letter/:id', :controller => 'reference_teachers', :action => 'process_letter'


  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
