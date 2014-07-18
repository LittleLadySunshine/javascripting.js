class PersonalProject < ActiveRecord::Base
  belongs_to :user

  def github_repo_url
    "https://github.com/#{user.github_username}/#{github_repo_name}"
  end
end
