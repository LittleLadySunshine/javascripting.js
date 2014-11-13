class CurriculumUnit < ActiveRecord::Base

  belongs_to :curriculum
  has_many :planned_lessons, dependent: :destroy
  has_many :lesson_plans, through: :planned_lessons

  validates :curriculum, presence: true
  validates :name, presence: true, uniqueness: {case_sensitive: false, scope: :curriculum_id}
  validates :position, presence: true, numericality: true, uniqueness: {scope: :curriculum_id}
  validates :objectives, presence: true
  validates :assessment, presence: true

  before_validation on: :create do
    if curriculum && !position
      max_position = self.class.ordered.where(curriculum_id: curriculum).last.try(:position) || 0
      self.position = max_position + 1
    end
  end

  def self.ordered
    order(:position)
  end

end
