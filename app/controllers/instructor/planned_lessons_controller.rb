class Instructor::PlannedLessonsController < InstructorRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
    @curriculum_unit = CurriculumUnit.find(params[:curriculum_unit_id])
  end

  before_action except: :destroy do
    @lesson_plans = LessonPlan.ordered
    @last_position = PlannedLesson.ordered.where(curriculum_unit_id: @curriculum_unit).last.try(:position)
  end

  def new
    @planned_lesson = PlannedLesson.new
  end

  def create
    @planned_lesson = PlannedLesson.new(planned_lesson_params)
    @planned_lesson.curriculum_unit = @curriculum_unit

    if @planned_lesson.save
      redirect_to(
        instructor_cohort_curriculum_unit_path(@cohort, @curriculum_unit),
        notice: 'Lesson Plan was added successfully'
      )
    else
      render :new
    end
  end

  def edit
    @planned_lesson = PlannedLesson.find(params[:id])
  end

  def update
    @planned_lesson = PlannedLesson.find(params[:id])

    if @planned_lesson.update(planned_lesson_params)
      redirect_to(
        instructor_cohort_curriculum_unit_path(@cohort, @curriculum_unit),
        notice: 'Lesson Plan updated successfully'
      )
    else
      render :edit
    end
  end

  def destroy
    @planned_lesson = PlannedLesson.find_by(id: params[:id])
    @planned_lesson.try(:destroy)
    redirect_to(
      instructor_cohort_curriculum_unit_path(@cohort, @curriculum_unit),
      notice: 'Lesson Plan removed successfully'
    )
  end

  private

  def planned_lesson_params
    params.require(:planned_lesson).permit(
      :lesson_plan_id,
      :position,
    )
  end
end
