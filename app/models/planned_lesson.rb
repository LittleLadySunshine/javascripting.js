class PlannedLesson < ActiveRecord::Base

  belongs_to :curriculum_unit
  belongs_to :lesson_plan

  validates :curriculum_unit, presence: true
  validates :lesson_plan, presence: true
  validates :lesson_plan_id, uniqueness: {scope: :curriculum_unit_id}
  validates :position, presence: true, numericality: true, uniqueness: {scope: :curriculum_unit_id}

  before_validation on: :create do
    if curriculum_unit && !position
      max_position = self.class.ordered.where(curriculum_unit_id: curriculum_unit).last.try(:position) || 0
      self.position = max_position + 1
    end
  end

  def self.ordered
    order(:position)
  end

end
