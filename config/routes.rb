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
    resources :writeups, controller: 'student/writeups', only: :index
    resources :writeup_topics, only: [] do
      resources :writeups, only: [:new, :create, :edit, :update, :destroy], controller: 'student/writeups'
    end
    resources :pairings, controller: 'student/pairings'
    resources :students, :only => [:index, :show], controller: 'student/students'
    resources :exercises, :only => [:index, :show], controller: 'student/exercises' do
      resources :submissions, :only => [:new, :create, :edit, :update], controller: 'student/submissions'
    end
    resource :personal_project, :only => [:show, :edit, :update], controller: 'student/personal_projects'
    resources :action_plan_entries, controller: 'student/action_plan_entries', only: :index
    resources :class_notes, controller: 'student/class_notes' do
      get :today, on: :collection
    end
    resources :daily_plans do
      get :today, on: :collection
    end
  end

  resources :class_projects do
    resources :features, controller: 'class_project_features'
  end

  namespace :instructor do
    resources :users
    resources :lesson_plans
    resources :curriculums, except: :show do
      resources :curriculum_units do
        resources :planned_lessons, except: %i(index show)
      end
    end
    resources :exercises, :except => :show
    resources :assessments

    resources :cohorts do
      get :one_on_ones, :on => :member
      get :acceptance, :on => :member
      get :social, :on => :member
      resources :writeup_topics do
        resources :writeups
      end
      resources :tracker_accounts
      resources :staffings, except: [:show]
      resources :pairs
      resources :imports, only: [:index, :create]
      resources :students, :only => [:new, :create, :show, :edit, :update] do
        resources :action_plan_entries
      end
      resources :projects, only: :index
      resources :action_plans, only: :index
      resources :cohort_exercises
    end
  end

  get "/personal_information" => "personal_information#edit", :as => :personal_information
  patch "/personal_information" => "personal_information#update"

end
