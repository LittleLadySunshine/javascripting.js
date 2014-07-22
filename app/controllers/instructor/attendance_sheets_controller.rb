class Instructor::AttendanceSheetsController < InstructorRequiredController
  def new
    @attendance_sheet = AttendanceSheet.new
    @cohort = user_session.current_user.cohort
    @students = @cohort.students
    # set holidays to National Holidays only

    @holidays = [Date.new(2014,7,4), Date.new(2014,9,1)]
    @today = Date.today
    # set submitted dates to be per current_user's cohort

    @submitted_dates = AttendanceSheet.where(cohort_id: @cohort[:id]).map {|sheet| sheet.sheet_date }
    @class_dates = (date_range(@cohort, @today) - @submitted_dates - @holidays).reverse!
  end

  def create
    cohort = user_session.current_user.cohort

    AttendanceSheet.create!(
      :sheet_date => params[:dropdown_date],
      :cohort_id => cohort.id,
      :attendances_attributes => params[:attendance_sheet][:attendances]
    )

    redirect_to instructor_cohort_path(cohort), :notice => "Attendance successfully submitted"
  end

  def date_range(cohort, today)
    start_date = cohort.start_date
    @days_in_class = (start_date..today).map {|day| day unless day.saturday? or day.sunday? }
    @days_in_class.compact!
  end


end
