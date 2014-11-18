require 'rails_helper'

describe "Submissions API" do
  describe 'GET /api/cohort_exercises/:cohort_exercise_id/submissions' do
    it 'shows all submissions for that cohort exercise' do
      cohort = create_cohort
      exercise = create_exercise
      cohort_exercise = CohortExercise.create!(
        cohort: cohort,
        exercise: exercise
      )

      student = create_user(
        email: 'user1@example.com',
        cohort: cohort,
        github_username: "someuser1"
      )

      submission = Submission.create!(
        user_id: student.id,
        exercise_id: exercise.id,
        github_repo_name: "song-that-doesnt-end",
      )

      get "/api/cohort_exercises/#{cohort_exercise.to_param}/submissions"

      response_json = JSON.parse(response.body, symbolize_names: true)
      expect(response_json).to match_array([
        {
          id: submission.id,
          user_id: student.id,
          github_username: "someuser1",
          exercise_id: exercise.id,
          github_repo_name: "song-that-doesnt-end",
        }
      ])
    end
  end
end
