class AddClassNotesRepoNameToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :class_notes_repo_name, :string
  end
end
