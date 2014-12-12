class CleanupUnusedTablesAndColumns < ActiveRecord::Migration
  def change
    drop_table :personal_projects
    remove_column :users, :gcamp_tracker_url
    remove_column :users, :gcamp_url
    remove_column :users, :employer
  end
end
