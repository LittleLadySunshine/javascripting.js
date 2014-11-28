class DailyPlan < ActiveRecord::Base

  belongs_to :cohort

  validates :cohort, presence: true
  validates :date, presence: true, uniqueness: {scope: :cohort_id}
  validates :description, presence: true

  def self.ordered
    order('date desc')
  end

  def self.grouped_by_week(cohort)
    grouped_plans = where(cohort_id: cohort).group_by do |plan|
      [plan.date.strftime("%G").to_i, plan.date.strftime("%V").to_i]
    end

    grouped_plans.sort_by(&:first).map.with_index(1) do |(_, days), week_number|
      [week_number, days.sort_by(&:date)]
    end.reverse
  end

  def to_param
    date.strftime("%Y-%m-%d")
  end

end
