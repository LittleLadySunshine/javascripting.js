class Instructor::CurriculumUnitsController < InstructorRequiredController

  before_action do
    @curriculum = Curriculum.find(params[:curriculum_id])
  end

  before_action except: [:index, :destroy] do
    @last_position = CurriculumUnit.ordered.where(curriculum_id: @curriculum).last.try(:position)
  end

  def index
    @curriculum_units = CurriculumUnit.ordered.where(curriculum_id: @curriculum)
  end

  def new
    @curriculum_unit = CurriculumUnit.new
  end

  def create
    @curriculum_unit = CurriculumUnit.new(curriculum_unit_params)
    @curriculum_unit.curriculum = @curriculum

    if @curriculum_unit.save
      redirect_to(
        instructor_curriculum_curriculum_unit_path(@curriculum, @curriculum_unit),
        notice: 'Curriculum Unit successfully created'
      )
    else
      render :new
    end
  end

  def show
    @curriculum_unit = CurriculumUnit.where(curriculum_id: @curriculum).find(params[:id])
  end

  def edit
    @curriculum_unit = CurriculumUnit.where(curriculum_id: @curriculum).find(params[:id])
  end

  def update
    @curriculum_unit = CurriculumUnit.where(curriculum_id: @curriculum).find(params[:id])

    if @curriculum_unit.update(curriculum_unit_params)
      redirect_to(
        instructor_curriculum_curriculum_unit_path(@curriculum, @curriculum_unit),
        notice: 'Curriculum Unit successfully updated'
      )
    else
      render :edit
    end
  end

  def destroy
    @curriculum_unit = CurriculumUnit.where(curriculum_id: @curriculum).find_by(id: params[:id])
    @curriculum_unit.try(:destroy)
    redirect_to(
      instructor_curriculum_curriculum_units_path(@curriculum, @curriculum_unit),
      notice: "Unit was deleted successfully"
    )
  end

  private

  def curriculum_unit_params
    params.require(:curriculum_unit).permit(
      :name,
      :position,
      :objectives,
      :assessment,
      :essential_questions,
      :rationale,
      :activities,
    )
  end
end
