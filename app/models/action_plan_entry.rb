class ActionPlanEntry < ActiveRecord::Base

  belongs_to :user
  belongs_to :cohort

  validates :description, presence: true

  def self.for_cohort_and_student(cohort, user)
    where(cohort_id: cohort, user_id: user)
  end

end
