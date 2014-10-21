class Instructor::ActionPlanEntriesController < InstructorRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
    @user = User.for_cohort(@cohort).find(params[:student_id])
  end

  def index
    @entries = ActionPlanEntry.for_cohort_and_student(@cohort, @user).order('created_at desc')
  end

  def new
    @entry = ActionPlanEntry.new
  end

  def create
    @entry = ActionPlanEntry.new(entry_params)
    @entry.user = @user
    @entry.cohort = @cohort

    if @entry.save
      redirect_to(
        instructor_cohort_student_action_plan_entries_path(@cohort, @user),
        notice: 'Entry created successfully'
      )
    else
      render :new
    end
  end

  def edit
    @entry = ActionPlanEntry.for_cohort_and_student(@cohort, @user).find(params[:id])
  end

  def update
    @entry = ActionPlanEntry.for_cohort_and_student(@cohort, @user).find(params[:id])

    if @entry.update(entry_params)
      redirect_to(
        instructor_cohort_student_action_plan_entries_path(@cohort, @user),
        notice: 'Entry updated successfully'
      )
    else
      render :edit
    end
  end

  def destroy
    @entry = ActionPlanEntry.for_cohort_and_student(@cohort, @user)
      .find_by_id(params[:id])
      .try(:destroy)

    redirect_to(
      instructor_cohort_student_action_plan_entries_path(@cohort, @user),
      notice: 'Entry deleted successfully'
    )
  end

  private

  def entry_params
    params.require(:action_plan_entry).permit(:description)
  end

end
