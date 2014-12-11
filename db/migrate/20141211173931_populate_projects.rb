class PopulateProjects < ActiveRecord::Migration
  class MigrationUser < ActiveRecord::Base
    self.table_name = :users
  end

  class MigrationProject < ActiveRecord::Base
    self.table_name = :student_projects
  end

  class MigrationPersonalProject < ActiveRecord::Base
    self.table_name = :personal_projects
  end

  def up
    MigrationProject.reset_column_information

    users = User.all.index_by(&:id)

    MigrationPersonalProject.all.each do |personal_project|
      MigrationProject.create!(
        user_id: personal_project.user_id,
        name: personal_project.name,
        description: personal_project.description,
        github_url: "https://github.com/#{users[personal_project.user_id].github_username}/#{personal_project.github_repo_name}",
        tracker_url: personal_project.tracker_url,
        production_url: personal_project.production_url,
      )
    end

    users.each do |id, user|
      MigrationProject.create!(
        user_id: id,
        name: 'gCamp',
        description: 'A Rails app that has some of the same functionality as Basecamp.',
        github_url: "https://github.com/#{user.github_username}/gCamp",
        tracker_url: user.gcamp_tracker_url,
        production_url: user.gcamp_url,
      )
    end
  end
end
