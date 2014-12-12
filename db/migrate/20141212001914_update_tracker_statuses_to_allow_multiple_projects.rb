class UpdateTrackerStatusesToAllowMultipleProjects < ActiveRecord::Migration

  def change
    remove_index :tracker_statuses, :user_id
    execute 'delete from tracker_statuses'
    add_column :tracker_statuses, :class_project_id, :integer, null: false
    add_index :tracker_statuses, [:user_id, :class_project_id], unique: true
  end
end
