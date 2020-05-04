Rails.application.routes.draw do
  root 'homes#index'
  get 'home/about' => 'homes#about' , as: 'home_about'
  devise_for :users, controllers: {
		sessions: 'users/sessions',
    registrations: 'users/registrations',
    :passwords => 'users/passwords'
  }
  devise_scope :users do
      resources :users, :only => [:index, :show, :edit, :update]
  end
  resources :books, :only => [:index, :show, :create, :edit, :update, :destroy]
  
end
