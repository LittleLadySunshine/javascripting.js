class Instructor::CohortsController < InstructorRequiredController

  def show
    students = User.for_cohort(params[:id]).sort_by { |user| user.full_name.downcase }
    cohort = Cohort.find(params[:id])
    render 'show',
           :locals => {
             :students => students,
             :lucky_winner => students.sample,
             :cohort => cohort
           }
  end

  def one_on_ones
    cohort = Cohort.find(params[:id])

    students = User.for_cohort(params[:id])
    all_instructors = User.instructors
    selected_instructors = if params[:instructor_ids]
                             all_instructors.select { |instructor| params[:instructor_ids].include?(instructor.id.to_s) }
                           else
                             all_instructors
                           end
    scheduler = OneOnOneScheduler.new(students, selected_instructors)
    scheduler.generate_schedule
    render 'one_on_ones',
           :locals => {
             :cohort_name => cohort.name,
             :appointments => scheduler.appointments,
             :unscheduled_students => scheduler.unscheduled_students,
             :all_instructors => all_instructors,
             :selected_instructors => selected_instructors,
           }
  end
end
