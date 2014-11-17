class Instructor::CohortsController < InstructorRequiredController

  def index
    @cohorts = Cohort.all
  end

  def new
    @cohort = Cohort.new
  end

  def create
    @cohort = Cohort.new(cohort_params)

    if @cohort.save
      flash[:notice] = "Cohort created"
      redirect_to instructor_cohorts_path
    else
      render :new
    end
  end

  def edit
    @cohort = Cohort.find(params[:id])
  end

  def update
    @cohort = Cohort.find(params[:id])

    if @cohort.update(cohort_params)
      flash[:notice] = "Cohort saved"
      redirect_to instructor_cohort_path(@cohort)
    else
      render :edit
    end
  end

  def show
    students = User.for_cohort(params[:id]).sort_by { |user| user.full_name.downcase }
    cohort = Cohort.find(params[:id])
    render('show', :locals => {:students => students,
                               :lucky_winner => students.sample,
                               :cohort => cohort})
  end

  def one_on_ones
    cohort = Cohort.find(params[:id])

    students = User.for_cohort(params[:id])
    all_instructors = cohort.instructors
    selected_instructors = if params[:instructor_ids]
                             all_instructors.select { |instructor| params[:instructor_ids].include?(instructor.id.to_s) }
                           else
                             all_instructors
                           end
    scheduler = OneOnOneScheduler.new(students, selected_instructors)
    scheduler.generate_schedule
    render('one_on_ones', :locals => {
      :cohort => cohort,
      :cohort_name => cohort.name,
      :appointments => scheduler.appointments,
      :unscheduled_students => scheduler.unscheduled_students,
      :all_instructors => all_instructors,
      :selected_instructors => selected_instructors}
    )
  end

  def acceptance
    @cohort = Cohort.find(params[:id])
    @users = User.for_cohort(@cohort)
  end

  def mentors
    @cohort = Cohort.find(params[:id])
    @users = User.for_cohort(@cohort)
    @mentors = Mentor.where(user_id: @users)
  end

  def social
    @cohort = Cohort.find(params[:id])
    @users = User.for_cohort(@cohort)
  end

  private

  def cohort_params
    params.require(:cohort).permit(
      :name,
      :start_date,
      :end_date,
      :google_maps_location,
      :directions,
      :showcase,
      :curriculum_id,
      :curriculum_site_url,
      :pair_feedback_url,
      :show_employment_ribbon,
      :hero
    )
  end
end
