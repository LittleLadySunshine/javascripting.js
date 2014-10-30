class Instructor::ProjectsController < InstructorRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  def index
    @projects = PersonalProject.for_cohort(@cohort)
  end

end
