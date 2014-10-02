class Instructor::DashboardController < InstructorRequiredController

  layout 'application_bootstrap'

  def index
    @cohorts = Cohort.all
  end
end
