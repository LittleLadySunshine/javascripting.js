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

  def send_one_on_ones
    instructor_appointments = {}
    params[:appointments].values.each do |appointment|
      student = User.find(appointment[:student_id])
      instructor_appointments[appointment[:instructor_id]] ||= []
      instructor_appointments[appointment[:instructor_id]] << OpenStruct.new(
        student: student,
        time: appointment[:time]
      )
      StudentMailer.one_on_one(
        student,
        User.find(appointment[:instructor_id]),
        appointment[:time],
      ).deliver
    end
    instructor_appointments.each do |instructor_id, appointments|
      InstructorMailer.one_on_one_schedule(User.find(instructor_id), appointments).deliver
    end
    redirect_to one_on_ones_instructor_cohort_path(params[:id]), notice: "Invitations were sent!"
  end

  def one_on_ones
    @start_time = params[:start_time].presence || '1:00pm'
    cohort = Cohort.find(params[:id])

    students = User.for_cohort(params[:id])
    all_instructors = cohort.instructors
    selected_instructors = if params[:instructor_ids]
                             all_instructors.select { |instructor| params[:instructor_ids].include?(instructor.id.to_s) }
                           else
                             all_instructors
                           end
    scheduler = OneOnOneScheduler.new(students, selected_instructors, @start_time)
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
    @tracker_statuses = TrackerStatus.where(user_id: @users).index_by(&:user_id)
    @users = @users.sort_by{|user| @tracker_statuses[user.id].try(:delivered) || 0 }.reverse
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
      :pair_feedback_url,
      :show_employment_ribbon,
      :hero,
      :prereqs,
      :calendar_url,
      :greenhouse_job_id,
    )
  end
end
