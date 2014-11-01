class Cohort < ActiveRecord::Base
  validates :name, :directions, :google_maps_location, :start_date, :end_date, :presence => true
  validates :curriculum_site_url, presence: true

  has_many :cohort_exercises
  has_many :exercises, :through => :cohort_exercises
  has_many :users
  has_many :staffings
  has_many :writeup_topics
  has_many :instructors, :through => :staffings, :source => :user

  mount_uploader :hero, HeroUploader

  def order_added_exercises
    cohort_exercises.includes(:exercise).order(:created_at).map(&:exercise)
  end
end
