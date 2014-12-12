class UpdateCurrentStatusToCurrentState < ActiveRecord::Migration
  def change
    execute 'delete from student_stories'
    rename_column :student_stories, :current_status, :current_state
    add_column :student_stories, :pivotal_tracker_id, :bigint, null: false
  end
end
