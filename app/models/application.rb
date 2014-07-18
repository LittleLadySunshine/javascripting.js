class Application < ActiveRecord::Base
  mount_uploader :resume, ResumeUploader
  belongs_to :job
  belongs_to :user

  enum :status => ["pending", "applied"]

  validates :user, :presence => true
  validates :job, :presence => true
  validates_uniqueness_of :job_id, :scope => [:user_id]
end
