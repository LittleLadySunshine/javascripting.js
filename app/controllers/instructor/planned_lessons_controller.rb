class Instructor::PlannedLessonsController < InstructorRequiredController

  before_action do
    @curriculum = Curriculum.find(params[:curriculum_id])
    @curriculum_unit = CurriculumUnit.find(params[:curriculum_unit_id])
  end

  before_action except: :destroy do
    if params[:filter]
      @lesson_plans = LessonPlan.tagged_with(params[:filter].split(',').map(&:strip))
    else
      @lesson_plans = LessonPlan.ordered
    end
  end

  def index
    all_planned_lessons = PlannedLesson.where(curriculum_unit_id: @curriculum_unit)
    already_added = all_planned_lessons.index_by do |planned_lesson|
      planned_lesson.lesson_plan
    end
    @planned_lessons = @lesson_plans.inject({}) do |hash, lesson_plan|
      hash[lesson_plan] = already_added[lesson_plan] || PlannedLesson.new
      hash
    end
  end

  include Reorderable
  def reorder
    update_positions PlannedLesson.where(curriculum_unit_id: @curriculum_unit)
  end

  def new
    @planned_lesson = PlannedLesson.new
  end

  def create
    @planned_lesson = PlannedLesson.new(planned_lesson_params)
    @planned_lesson.curriculum_unit = @curriculum_unit
    @planned_lesson.save!
    redirect_to(
      instructor_curriculum_curriculum_unit_planned_lessons_path(
        @curriculum, @curriculum_unit, filter: params[:filter]
      ),
      notice: 'Lesson Plan was added successfully'
    )
  end

  def destroy
    @planned_lesson = PlannedLesson.find_by(id: params[:id])
    @planned_lesson.try(:destroy)
    if params[:multi]
      redirect_to(
        instructor_curriculum_curriculum_unit_planned_lessons_path(
          @curriculum, @curriculum_unit, filter: params[:filter]
        ),
        notice: 'Lesson Plan removed successfully'
      )
    else
      redirect_to(
        instructor_curriculum_curriculum_unit_path(@curriculum, @curriculum_unit, anchor: 'lesson-plans'),
        notice: 'Lesson Plan removed successfully'
      )
    end
  end

  private

  def planned_lesson_params
    params.require(:planned_lesson).permit(
      :lesson_plan_id,
      :position,
    )
  end
end
