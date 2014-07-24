class AttendanceDates
  attr_accessor :cohort

  def initialize(cohort)
    @cohort = cohort
  end

  def calculate_dates
    @holidays = [Date.new(2014,7,4), Date.new(2014,9,1)]
    @submitted_dates = AttendanceSheet.where(cohort_id: @cohort[:id]).map {|sheet| sheet.sheet_date }
    @class_dates = (date_range(@cohort, Date.today) - @submitted_dates - @holidays).reverse!
  end

  private
    def date_range(cohort, today)
      start_date = cohort.start_date
      @days_in_class = (start_date..today).map {|day| day unless day.saturday? or day.sunday? }
      @days_in_class.compact!
    end
end