class LessonPlan < ActiveRecord::Base

  acts_as_taggable

  validates :name, presence: true, uniqueness: {case_sensitive: false}

end
