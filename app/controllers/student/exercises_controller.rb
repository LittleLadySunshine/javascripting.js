class Student::ExercisesController < SignInRequiredController
  def index
    user = user_session.current_user

    @exercises = user.cohort_exercises.map do |exercise|
      StudentCohortExercise.new(user.id, exercise)
    end
  end

  def show
    user = user_session.current_user
    exercise = Exercise.find(params[:id])

    @exercise = StudentCohortExercise.new(user.id, exercise)
  end

  class StudentCohortExercise
    include ActionView::Helpers
    include Rails.application.routes.url_helpers

    def initialize(user_id, exercise)
      @user_id = user_id
      @exercise = exercise
    end

    delegate :name, :github_repo_url, :to_param, :tag_list, to: :exercise

    def completed_text
      if completed?
        "✓"
      else
        ""
      end
    end

    def submission_text
      if completed?
        "You've submitted: #{link_to(submission.github_repo_name, submission.github_repo_url)}".html_safe
      else
        "You have not submitted a solution"
      end
    end

    def submission_link
      if completed?
        ""
      else
        link_to("Submit Code", new_student_exercise_submission_path(exercise)).html_safe
      end
    end

    private

    attr_reader :exercise, :user_id

    def completed?
      submission.present?
    end

    def submission
      @_submission ||= exercise.submission_for(user_id)
    end
  end
end

