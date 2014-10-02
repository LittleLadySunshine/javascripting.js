class Student::InfoController < SignInRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

end
