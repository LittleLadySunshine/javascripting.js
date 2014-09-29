class Student::InfoController < SignInRequiredController
  layout 'application_bootstrap', only: [:index]
  def index
    @cohort = user_session.current_cohort
  end
end
