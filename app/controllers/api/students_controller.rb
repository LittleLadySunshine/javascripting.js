module Api
  class StudentsController < ActionController::Base

    def index
      cohort = Cohort.find(params[:cohort_id])
      students = User.for_cohort(cohort)
      results = students.map do |student|
        {
          id: student.id,
          first_name: student.first_name,
          last_name: student.last_name,
          github_username: student.github_username,
        }
      end

      render json: results
    end

  end
end
