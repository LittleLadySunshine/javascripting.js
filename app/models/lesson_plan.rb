class LessonPlan < ActiveRecord::Base

  acts_as_taggable

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def self.ordered
    order('lower(name)')
  end

  def completed_sections
    fields = %i(objectives assessment activity description)
    fields.reduce(0) do |sum, field|
      sum + (send("#{field}?") ? 1 : 0)
    end
  end

end
