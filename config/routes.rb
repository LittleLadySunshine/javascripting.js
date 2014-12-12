Students::Application.routes.draw do
  root :to => "showcases#index"

  namespace :api do
    get 'me' => 'base#me'
    get 'sign-in' => 'auth#sign_in'
    resources :cohort_exercises, only: [] do
      resources :submissions, only: :index
    end
    resources :students, only: :index
    resources :cohorts, only: :index do
      resources :students, only: :index
    end
  end

  resources :showcases
  resources :students, :only => :show

  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure" => "sessions#failure"
  get "/logout" => "sessions#destroy", :as => "logout"

  get "/preparation" => "public_pages#preparation_index", :as => "preparations"
  get "/preparation/:id" => "public_pages#preparation", :as => "preparation"
  get "/calendar" => "public_pages#calendar", :as => "calendar"

  resources :users, only: [] do
    resources :projects
    resources :epics, controller: 'user_epics' do
      post :add_to_tracker, on: :member
    end
  end

  resources :cohorts, only: [] do
    get "/info" => "student/info#index", :as => "info"
    get "/prereqs" => "student/info#prereqs", :as => "prereqs"
    resources :applications, only: [:index], controller: 'greenhouse_applications' do
      post :refresh, on: :collection
    end
    resources :writeups, controller: 'student/writeups', only: :index
    resources :writeup_topics, only: [] do
      resources :writeups, only: [:new, :create, :edit, :update, :destroy], controller: 'student/writeups'
    end
    resources :pairings, controller: 'student/pairings'
    resources :students, :only => [:index, :show], controller: 'student/students' do
      resources :mentors
    end
    resources :exercises, :only => [:index, :show], controller: 'student/exercises' do
      resources :submissions, :only => [:new, :create, :edit, :update], controller: 'student/submissions'
    end
    resources :action_plan_entries, controller: 'student/action_plan_entries', only: :index
    resources :daily_plans do
      get :today, on: :collection
    end

    resources :rubrics, only: %i(index show) do
      resources :users, only: [] do
        resources :assessments, only: [:index, :new, :create]
      end
    end
  end

  resources :class_projects do
    resources :epics do
      resources :stories do
        post :reorder, on: :collection
      end
      post :reorder, on: :collection
    end
  end

  namespace :instructor do
    resources :users do
      resources :employments, except: [:index, :show]
    end
    resources :lesson_plans do
      resources :lessons, only: [:create, :destroy]
    end
    resources :curriculums, except: :show do
      resources :curriculum_units do
        post :reorder, on: :collection
        resources :planned_lessons, except: %i(new show edit update) do
          post :reorder, on: :collection
        end
      end
    end
    resources :exercises, :except => :show
    resources :rubrics

    resources :cohorts do
      get :one_on_ones, :on => :member
      post :send_one_on_ones, on: :member
      get :acceptance, :on => :member
      post :refresh_acceptance, :on => :member
      get :mentors, :on => :member
      get :social, :on => :member

      resources :writeup_topics do
        resources :writeups
      end
      resources :tracker_accounts
      resources :staffings, except: [:show] do
        post :add_as_owner, on: :member
      end
      resources :pairs
      resources :imports, only: [:index, :create]
      resources :students, :only => [] do
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
