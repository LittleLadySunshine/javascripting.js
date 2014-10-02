class Student::InfoController < SignInRequiredController

  def index
    @cohort = user_session.current_cohort
  end

end
