class GreenhouseApplicationsController < InstructorRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  def index
    @applications = GreenhouseApplication.all
  end

  def refresh
    GreenhouseHarvester.new(@cohort).harvest
    redirect_to cohort_applications_path(@cohort)
  end

end
