class Instructor::ActionPlansController < InstructorRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  def index
    @students = User.for_cohort(@cohort)
  end

end
