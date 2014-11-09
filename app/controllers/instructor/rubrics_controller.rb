class Instructor::RubricsController < InstructorRequiredController

  def index
    @rubrics = Rubric.all
  end

  def new
    @rubric = Rubric.new
  end

  def show
    @rubric = Rubric.find(params[:id])
  end

  def create
    @rubric = Rubric.new(rubric_params)

    if @rubric.save
      redirect_to(
        instructor_rubric_path(@rubric),
        notice: 'Rubric created successfully'
      )
    else
      render :new
    end
  end

  def edit
    @rubric = Rubric.find(params[:id])
  end

  def update
    @rubric = Rubric.find(params[:id])

    if @rubric.update(rubric_params)
      redirect_to(
        instructor_rubric_path(@rubric),
        notice: 'Rubric updated successfully'
      )
    else
      render :edit
    end
  end

  def destroy
    @rubric = Rubric.find_by(id: params[:id]).try(:destroy)
    redirect_to(
      instructor_rubrics_path,
      notice: "Rubric was deleted successfully"
    )
  end

  private

  def rubric_params
    params.require(:rubric).permit(:name, :questions_json)
  end

end
