class Instructor::LessonPlansController < InstructorRequiredController

  def index
    @lesson_plans = LessonPlan.order('lower(name)')
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
      redirect_to(
        instructor_lesson_plan_path(@lesson_plan),
        notice: 'Lesson Plan successfully created'
      )
    else
      render :new
    end
  end

  def show
    active_staffings = Staffing.where(user_id: user_session.current_user).active
    @cohorts = active_staffings.map(&:cohort).select(&:class_notes_repo_name?)
    @lesson_plan = LessonPlan.find(params[:id])
  end

  def edit
    @lesson_plan = LessonPlan.find(params[:id])
  end

  def update
    @lesson_plan = LessonPlan.find(params[:id])

    if @lesson_plan.update(lesson_plan_params)
      redirect_to(
        instructor_lesson_plan_path(@lesson_plan),
        notice: 'Lesson Plan successfully created'
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
