class User < ActiveRecord::Base
  enum role: [ :student, :instructor ]

  validates :email, :uniqueness => {:case_sensitive => false}
  validates :github_id, :uniqueness => { :case_sensitive => false, :allow_nil => true }
  validates :email, :first_name, :last_name, :cohort, :presence => true

  belongs_to :cohort
  has_many :submissions
  has_one :personal_project

  mount_uploader :avatar, AvatarUploader

  def self.for_cohort(cohort_id)
    student.where(:cohort_id => cohort_id)
  end

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

  def twitter_url
    "https://twitter.com/#{twitter}"
  end

  def github_url
    "https://github.com/#{github_username}"
  end
end
