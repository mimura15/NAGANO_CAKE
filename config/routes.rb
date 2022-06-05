Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, except: [:destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
  end
 
 get '/admin' => 'admin/homes#top'
 
 root to: 'public/homes#top'
 get '/about' => 'public/homes#about'
 get '/customers/my_page' => 'public/customers#show'
 
 scope module: :public do
   resources :customers, only: [:edit, :update] do
     collection do
      get :unsubscribe
      patch :withdraw
     end
    end
    resources :addresses, except: [:new, :show]
    resources :items, only: [:index, :show]
    resources :cart_items, except: [:new, :show, :edit] do
      collection do
        delete :destroy_all
      end
    end
    resources :orders, except: [:edit, :update, :destroy] do
      collection do
        post :confirm
        get :complete
      end
    end
  end
  
end
