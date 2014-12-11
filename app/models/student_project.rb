class StudentProject < ActiveRecord::Base

  mount_uploader :screenshot, ScreenshotUploader

  belongs_to :user
  validates :user, presence: true
  validates :github_url,
            format: {
              with: /\Ahttps?:\/\/.+/,
              message: "must be a full URL that starts with 'http'",
              allow_blank: true,
            }
  validates :tracker_url,
            format: {
              with: /\Ahttps?:\/\/.+/,
              message: "must be a full URL that starts with 'http'",
              allow_blank: true,
            }
  validates :production_url,
            format: {
              with: /\Ahttps?:\/\/.+/,
              message: "must be a full URL that starts with 'http'",
              allow_blank: true,
            }

  def self.for_user(user)
    where(user_id: user)
  end

end
