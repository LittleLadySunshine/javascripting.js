class User < ActiveRecord::Base
  enum role: [ :student, :instructor ]
  enum status: [ :active, :inactive ]

  validates :greenhouse_candidate_id, uniqueness: {allow_blank: true}
  validates :email, :uniqueness => {:case_sensitive => false}
  validates :github_id, :uniqueness => { :case_sensitive => false, :allow_nil => true }
  validates :email, :first_name, :last_name, :presence => true
  validates :cohort, presence: {if: :student?, message: "can't be blank for students"}
  validates :linkedin,
            format: {
              with: /\Ahttps?:\/\/.+/,
              message: "must be a full URL that starts with 'http'",
              allow_blank: true,
            }

  belongs_to :cohort
  has_many :submissions, dependent: :destroy
  has_many :employments, dependent: :destroy
  has_many :staffings, dependent: :destroy
  has_one :personal_project, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  def self.for_cohort(cohort_id)
    where(:cohort_id => cohort_id).order(:first_name, :last_name)
  end

  def cohort_exercises
    cohort ? cohort.order_added_exercises : []
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

  def github_url
    "https://github.com/#{github_username}"
  end

  def twitter_url
    if twitter =~ /https?:\/\//
      twitter
    else
      "https://twitter.com/#{twitter}"
    end
  end

  def is_employed?
    employments.active.present?
  end
end
