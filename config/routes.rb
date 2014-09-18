Students::Application.routes.draw do
  root :to => "showcases#index"

  resources :showcases
  resources :students, :only => :show

  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure" => "sessions#failure"
  get "/logout" => "sessions#destroy", :as => "logout"

  get "/preparation" => "public_pages#preparation", :as => "preparation"
  get "/calendar" => "public_pages#calendar", :as => "calendar"

  namespace :student do
    get "/info" => "info#index", :as => "info"

    resources :students, :only => [:index, :show]

    resource :personal_project, :only => [:show, :edit, :update]

    resources :exercises, :only => [:index, :show] do
      resources :submissions, :only => [:new, :create, :edit, :update]
    end
  end


  namespace :instructor do
    get "dashboard" => "dashboard#index"
    resources :exercises, :except => :show

    resources :cohorts do
      get :one_on_ones, :on => :member

      resources :pairs
      resources :students, :only => [:new, :create, :show, :edit, :update]
      resources :cohort_exercises

      resources :attendance_sheets, :only => [:new, :create]
    end
  end

  get "/personal_information" => "personal_information#edit", :as => :personal_information
  patch "/personal_information" => "personal_information#update"

end
