class Instructor::ProjectsController < InstructorRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  def index
    @projects = StudentProject.for_user(User.for_cohort(@cohort))
                  .sort_by{|project| project.user.full_name }
  end

end
