class Instructor::LessonPlansController < InstructorRequiredController

  before_action do
    if params[:curriculum_unit_id].present?
      @curriculum_unit = CurriculumUnit.find(params[:curriculum_unit_id])
    end
  end

  def index
    @lesson_plans = LessonPlan.ordered
    if params[:filter]
      @lesson_plans = @lesson_plans.tagged_with(params[:filter].split(',').map(&:strip))
    end
  end

  def new
    @lesson_plan = LessonPlan.new
  end

  def create
    @lesson_plan = LessonPlan.new(lesson_plan_params)

    if @lesson_plan.save
      if @curriculum_unit
        PlannedLesson.create!(
          curriculum_unit: @curriculum_unit,
          lesson_plan: @lesson_plan
        )
      end
      redirect_to(
        instructor_lesson_plan_path(@lesson_plan, curriculum_unit_id: params[:curriculum_unit_id].presence),
        notice: 'Lesson Plan successfully created'
      )
    else
      render :new
    end
  end

  def show
    active_staffings = Staffing.where(user_id: current_user).active
    @cohorts = active_staffings.map(&:cohort)
    @lesson_plan = LessonPlan.find(params[:id])
    @lesson = Lesson.new
    @lessons = Lesson.all
  end

  def edit
    @lesson_plan = LessonPlan.find(params[:id])
  end

  def update
    @lesson_plan = LessonPlan.find(params[:id])

    if @lesson_plan.update(lesson_plan_params)
      redirect_to(
        instructor_lesson_plan_path(@lesson_plan, curriculum_unit_id: params[:curriculum_unit_id].presence),
        notice: 'Lesson Plan successfully updated'
      )
    else
      render :edit
    end
  end

  private

  def lesson_plan_params
    params.require(:lesson_plan).permit(
      :name,
      :objectives,
      :assessment,
      :activity,
      :description,
      :tag_list,
    )
  end
end
