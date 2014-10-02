class Instructor::DashboardController < InstructorRequiredController

  def index
    @cohorts = Cohort.all
  end

end
