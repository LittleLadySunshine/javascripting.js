class CohortExercise < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :cohort
  before_destroy :check_for_submissions?

  validates :exercise, :cohort, :presence => true
  delegate :submissions, :name, :to => :exercise

  def students_missing_submission
    cohort.students - submissions.map(&:user)
  end

  def check_for_submissions?
    if self.submissions.count == 0
      true
    else
      false
    end
  end

end
