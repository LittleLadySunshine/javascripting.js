class AssociateCohortsWithCurriculums < ActiveRecord::Migration
  def change
    add_column :cohorts, :curriculum_id, :integer
    add_index :cohorts, :curriculum_id

    remove_column :curriculum_units, :cohort_id
  end
end
