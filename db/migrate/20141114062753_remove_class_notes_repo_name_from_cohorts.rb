class RemoveClassNotesRepoNameFromCohorts < ActiveRecord::Migration
  def change
    remove_column :cohorts, :class_notes_repo_name
  end
end
