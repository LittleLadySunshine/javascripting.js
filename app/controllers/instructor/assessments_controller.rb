class Instructor::AssessmentsController < InstructorRequiredController

  def index
    @assessments = Assessment.all
  end

  def new
    @assessment = Assessment.new
  end

  def show
    @assessment = Assessment.find(params[:id])
  end

  def create
    @assessment = Assessment.new(assessment_params)

    if @assessment.save
      redirect_to(
        instructor_assessment_path(@assessment),
        notice: 'Assessment created successfully'
      )
    else
      render :new
    end
  end

  def edit
    @assessment = Assessment.find(params[:id])
  end

  def update
    @assessment = Assessment.find(params[:id])

    if @assessment.update(assessment_params)
      redirect_to(
        instructor_assessment_path(@assessment),
        notice: 'Assessment updated successfully'
      )
    else
      render :edit
    end
  end

  def destroy
    @assessment = Assessment.find_by(id: params[:id]).try(:destroy)
    redirect_to(
      instructor_assessments_path,
      notice: "Assessment was deleted successfully"
    )
  end

  private

  def assessment_params
    params.require(:assessment).permit(:name, :questions_json)
  end

end
