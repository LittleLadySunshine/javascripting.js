class RubricsController < InstructorRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  def index
    @rubrics = Rubric.all
  end

  def show
    @rubric = Rubric.find(params[:id])
    @users = User.for_cohort(@cohort)
  end
end
