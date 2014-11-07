class ClassProject < ActiveRecord::Base

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  has_many :features, class_name: "ClassProjectFeature"

  def self.ordered
    order('lower(name)')
  end

end
