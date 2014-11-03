class PlannedLesson < ActiveRecord::Base

  belongs_to :curriculum_unit
  belongs_to :lesson_plan

  validates :curriculum_unit, presence: true
  validates :lesson_plan, presence: true
  validates :lesson_plan_id, uniqueness: {scope: :curriculum_unit_id}
  validates :position, presence: true, numericality: true, uniqueness: {scope: :curriculum_unit_id}

  def self.ordered
    order(:position)
  end

end
