require 'csv'

class ClassProjectFeature < ActiveRecord::Base

  enum category: [:mvp, :stretch]

  belongs_to :class_project

  validates :class_project, presence: true
  validates :name,
            presence: true,
            uniqueness: {scope: [:class_project_id, :category], case_sensitive: false}
  validates :position,
            presence: true,
            numericality: true,
            uniqueness: {scope: :class_project_id}

  def self.ordered
    order(:position)
  end

  def story_rows
    if stories?
      CSV.parse(stories) rescue []
    else
      []
    end
  end

end
