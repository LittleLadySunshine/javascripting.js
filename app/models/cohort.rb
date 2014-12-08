class Cohort < ActiveRecord::Base
  validates :name, :directions, :google_maps_location, :start_date, :end_date, :presence => true
  validates :greenhouse_job_id, uniqueness: {allow_blank: true}

  belongs_to :curriculum
  has_many :cohort_exercises, dependent: :destroy
  has_many :exercises, :through => :cohort_exercises
  has_many :users, dependent: :destroy
  has_many :staffings, dependent: :destroy
  has_many :writeup_topics, dependent: :destroy
  has_many :instructors, :through => :staffings, :source => :user
  has_many :lessons, dependent: :destroy

  mount_uploader :hero, HeroUploader

  def order_added_exercises
    cohort_exercises.includes(:exercise).order(:created_at).map(&:exercise)
  end

  def self.current
    where('? between start_date and end_date', Date.today)
  end

  def self.upcoming
    where('start_date > ?', Date.today)
  end
end
