Students::Application.routes.draw do
  root :to => "showcases#index"

  resources :showcases
  resources :students, :only => :show

  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure" => "sessions#failure"
  get "/logout" => "sessions#destroy", :as => "logout"

  get "/preparation" => "public_pages#preparation", :as => "preparation"
  get "/calendar" => "public_pages#calendar", :as => "calendar"

  resources :cohorts, only: [] do
    get "/info" => "student/info#index", :as => "info"
    resources :students, :only => [:index, :show], controller: 'student/students'
    resources :exercises, :only => [:index, :show], controller: 'student/exercises' do
      resources :submissions, :only => [:new, :create, :edit, :update], controller: 'student/submissions'
    end
    resource :personal_project, :only => [:show, :edit, :update], controller: 'student/personal_projects'
  end

  namespace :instructor do
    resources :users
    resources :exercises, :except => :show

    resources :cohorts do
      get :one_on_ones, :on => :member
      resources :tracker_accounts
      resources :staffings, except: [:show]
      resources :pairs
      resources :imports, only: [:index, :create]
      resources :students, :only => [:new, :create, :show, :edit, :update]
      resources :cohort_exercises
    end
  end

  get "/personal_information" => "personal_information#edit", :as => :personal_information
  patch "/personal_information" => "personal_information#update"

end
