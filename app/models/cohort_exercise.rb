class CohortExercise < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :cohort

  validates :exercise, :cohort, :presence => true
  delegate :submissions, :name, :to => :exercise

  def students_missing_submission
    cohort.students - submissions.map(&:user)
  end
end
