module Api
  class StudentsController < BaseController

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

      render json: {student: results}
    end

  end
end
