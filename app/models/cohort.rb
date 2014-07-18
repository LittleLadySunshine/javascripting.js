class Cohort < ActiveRecord::Base
  validates :name, :directions, :google_maps_location, :start_date, :end_date, :presence => true

  has_many :cohort_exercises
  has_many :exercises, :through => :cohort_exercises
  has_many :users

  def students
    users.where.not(:role_bit_mask => User::INSTRUCTOR)
  end

  def order_added_exercises
    cohort_exercises.includes(:exercise).order(:created_at).map(&:exercise)
  end
end
