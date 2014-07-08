class User < ActiveRecord::Base
  INSTRUCTOR = 1

  validates :email, uniqueness: {case_sensitive: false}
  validates :github_id, uniqueness: { case_sensitive: false, allow_nil: true }
  validates :email, :first_name, :last_name, :cohort, presence: true

  belongs_to :cohort
  has_many :submissions
  has_many :applications
  has_many :job_opportunities, through: :applications

  mount_uploader :avatar, AvatarUploader

  def self.for_cohort(cohort_id)
    where(cohort_id: cohort_id).where.not(role_bit_mask: INSTRUCTOR)
  end

  scope :instructors, -> { where(role_bit_mask: INSTRUCTOR) }

  def cohort_exercises
    cohort.order_added_exercises
  end

  def completed_exercises
    submissions.includes(:exercise).map(&:exercise)
  end

  def incomplete_exercises
    cohort_exercises - completed_exercises
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def is?(role)
    role_bit_mask & role != 0
  end

  def add_role(role)
    self.role_bit_mask += role
  end

  def twitter_url
    "https://twitter.com/#{twitter}"
  end


  def completed_applications
    applications.where(status: Application.statuses[:applied]).includes(:job_opportunity)
  end

  def pending_applications
    applications.where(status: Application.statuses[:pending]).includes(:job_opportunity)
  end
end
