class AddGreenhouseJobIdToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :greenhouse_job_id, :bigint
    add_index :cohorts, :greenhouse_job_id, unique: true
  end
end
