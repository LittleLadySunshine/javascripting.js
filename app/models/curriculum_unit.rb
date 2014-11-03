class CurriculumUnit < ActiveRecord::Base

  belongs_to :cohort

  validates :cohort, presence: true
  validates :name, presence: true, uniqueness: {case_sensitive: false, scope: :cohort_id}
  validates :position, presence: true, numericality: true, uniqueness: {scope: :cohort_id}
  validates :objectives, presence: true
  validates :assessment, presence: true

  def self.ordered
    order(:position)
  end

end
