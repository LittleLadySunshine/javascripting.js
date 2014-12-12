class TrackerStatus < ActiveRecord::Base

  belongs_to :user
  belongs_to :class_project
  validates :class_project, presence: true
  validates :user, presence: true, uniqueness: {scope: :class_project}
  validates :delivered, presence: true, numericality: true
  validates :accepted, presence: true, numericality: true
  validates :rejected, presence: true, numericality: true
  validates :started, presence: true, numericality: true
  validates :unstarted, presence: true, numericality: true
  validates :unscheduled, presence: true, numericality: true
  validates :finished, presence: true, numericality: true

end
