class Instructor::AttendanceSheetsController < InstructorRequiredController
  def new
    @attendance_sheet = AttendanceSheet.new
    @cohort = user_session.current_user.cohort
    @students = @cohort.students
    @class_dates = AttendanceDates.new(@cohort).calculate_dates
  end

  def create
    cohort = user_session.current_user.cohort

    AttendanceSheet.create!(
      sheet_date: params[:dropdown_date],
      cohort_id: cohort.id,
      attendances_attributes: params[:attendance_sheet][:attendances]
    )

    redirect_to instructor_cohort_path(cohort), notice: "Attendance successfully submitted"
  end

end