class WriteupTopic < ActiveRecord::Base

  belongs_to :cohort
  has_many :writeups

  validates :cohort, presence: true
  validates :subject, presence: true

  scope :active, ->{where(active: true)}

end
