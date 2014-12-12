class Story < ActiveRecord::Base

  belongs_to :epic
  validates :title, presence: true

  before_validation on: :create do
    if epic && !position
      max_position = self.class.ordered.where(epic_id: epic).last.try(:position) || 0
      self.position = max_position + 1
    end
  end

  def self.ordered
    order(:position)
  end

end
