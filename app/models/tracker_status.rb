class TrackerStatus < ActiveRecord::Base

  belongs_to :user
  validates :user, presence: true, uniqueness: true
  validates :delivered, presence: true, numericality: true
  validates :accepted, presence: true, numericality: true
  validates :rejected, presence: true, numericality: true
  validates :started, presence: true, numericality: true
  validates :unstarted, presence: true, numericality: true
  validates :unscheduled, presence: true, numericality: true
  validates :finished, presence: true, numericality: true

end
