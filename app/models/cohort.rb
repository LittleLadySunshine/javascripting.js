class Cohort < ActiveRecord::Base
  validates :name, :directions, :google_maps_location, :start_date, :end_date, :presence => true

  has_many :cohort_exercises
  has_many :exercises, :through => :cohort_exercises
  has_many :users
  has_many :staffings
  has_many :writeup_topics
  has_many :instructors, :through => :staffings, :source => :user
  belongs_to :curriculum
  has_many :lessons

  mount_uploader :hero, HeroUploader

  def order_added_exercises
    cohort_exercises.includes(:exercise).order(:created_at).map(&:exercise)
  end

  def self.current
    where('? between start_date and end_date', Date.today)
  end
end
