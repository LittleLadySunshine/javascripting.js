class PersonalProject < ActiveRecord::Base
  belongs_to :user

  def self.for_cohort(cohort)
    joins(:user).where(users: {cohort_id: cohort}).order("users.first_name, users.last_name")
  end

  def github_repo_url
    "https://github.com/#{user.github_username}/#{github_repo_name}"
  end
end
