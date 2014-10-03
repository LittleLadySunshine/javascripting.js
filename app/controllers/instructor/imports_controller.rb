require 'csv'

class Instructor::ImportsController < InstructorRequiredController

  def header_fields
    %w(first_name last_name email phone twitter blog address_1 address_2 city state zip_code linkedin)
  end

  private :header_fields
  helper_method :header_fields

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  def index
  end

  def create
    headers, @saved, @failed = import_csv
    if @failed.empty?
      redirect_to(
        instructor_cohort_path(@cohort),
        notice: "#{view_context.pluralize(@saved.length, "student")} were imported successfully!"
      )
    else
      @text = [headers.to_csv.strip]
      @text += @failed.values.map{|info| info[:row].to_csv.strip }
      @text = @text.join("\n")
      render :index
    end
  end

  private

  def import_csv
    saved, failed = {}, {}
    i = 1
    headers = []
    CSV.parse(params[:student_csv], headers: true, skip_blanks: true) do |row|
      headers = row.headers
      user = User.new(role: :student, cohort: @cohort)
      header_fields.each { |field| user.send("#{field}=", row[field].to_s.strip) }
      if user.save
        StudentMailer.invitation(user.email).deliver
        saved[i] = user
      else
        failed[i] = {user: user, row: row}
      end
      i += 1
    end
    return headers, saved, failed
  end

end
