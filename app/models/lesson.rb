class Lesson < ActiveRecord::Base

  belongs_to :cohort
  belongs_to :lesson_plan

  validates :date, presence: true
  validates :cohort_id , presence: true, uniqueness: true


end
