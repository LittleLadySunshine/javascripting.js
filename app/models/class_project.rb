class ClassProject < ActiveRecord::Base

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  has_many :epics, dependent: :destroy

  def self.ordered
    order('lower(name)')
  end

end
