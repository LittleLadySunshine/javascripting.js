class ClassProject < ActiveRecord::Base

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def self.ordered
    order('lower(name)')
  end

end
