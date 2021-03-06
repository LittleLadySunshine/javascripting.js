class Curriculum < ActiveRecord::Base

  has_many :curriculum_units, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :description, presence: true

  def self.ordered
    order('lower(name)')
  end

end
