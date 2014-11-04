class Instructor::CurriculumsController < InstructorRequiredController

  def index
    @curriculums = Curriculum.all
  end

  def new
    @curriculum = Curriculum.new
  end

  def create
    @curriculum = Curriculum.new(curriculum_params)

    if @curriculum.save
      redirect_to(
        instructor_curriculum_curriculum_units_path(@curriculum),
        notice: 'Curriculum successfully created'
      )
    else
      render :new
    end
  end

  def edit
    @curriculum = Curriculum.find(params[:id])
  end

  def update
    @curriculum = Curriculum.find(params[:id])

    if @curriculum.update(curriculum_params)
      redirect_to(
        instructor_curriculum_curriculum_units_path(@curriculum),
        notice: 'Curriculum successfully updated'
      )
    else
      render :edit
    end
  end

  def destroy
    @curriculum = Curriculum.find_by(id: params[:id])
    @curriculum.try(:destroy)
    redirect_to(
      instructor_curriculums_path,
      notice: 'Curriculum successfully deleted'
    )
  end

  private

  def curriculum_params
    params.require(:curriculum).permit(
      :name,
      :description,
    )
  end
end
