class AddClassProjectIdToStudentProjects < ActiveRecord::Migration

  class MigrationClassProject < ActiveRecord::Base
    self.table_name = :class_projects
  end

  def change
    add_column :student_projects, :class_project_id, :integer
    gcamp = MigrationClassProject.find_by(name: 'gCamp')
    if gcamp
      execute "update student_projects set class_project_id = #{gcamp.id} where name = 'gCamp'"
    end
  end
end
