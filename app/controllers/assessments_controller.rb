class AssessmentsController < InstructorRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
    @rubric = Rubric.find(params[:rubric_id])
    @user = User.find(params[:user_id])
  end

  def new
    @assessment = Assessment.new(date: Date.today)
  end

  def index
    @assessments = Assessment.where(
      user_id: @user,
      rubric_id: @rubric
    )
  end

  def create
    @assessment = Assessment.new(
      user: @user,
      rubric: @rubric,
      assessor: user_session.current_user,
      date: params[:assessment][:date],
      questions_json: @rubric.questions_json,
    )

    @assessment.set_response_json(params[:assessment].fetch(:responses, {}))

    if @assessment.save
      redirect_to(
        cohort_rubric_path(@cohort, @rubric),
        notice: "Assessment for #{@user.full_name} created successfully"
      )
    else
      render :new
    end
  end
end
