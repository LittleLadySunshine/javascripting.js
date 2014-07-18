class Instructor::AttendanceSheetsController < InstructorRequiredController
  def new
    @attendance_sheet = AttendanceSheet.new
    @cohort = user_session.current_user.cohort
    @students = @cohort.students
  end

  def create
    cohort = user_session.current_user.cohort

    AttendanceSheet.create!(
      :sheet_date => Date.today,
      :cohort_id => cohort.id,
      :attendances_attributes => params[:attendance_sheet][:attendances]
    )

    redirect_to instructor_cohort_path(cohort), :notice => "Attendance successfully submitted"
  end
end