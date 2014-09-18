class RemoveEmploymentTables < ActiveRecord::Migration
  def change
    drop_table :applications
    drop_table :companies
    drop_table :jobs
    remove_column :cohorts, :employment_phase
  end
end
