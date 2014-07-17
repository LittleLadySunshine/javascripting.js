class RenameJobOpportunities < ActiveRecord::Migration
  def change
    rename_table :job_opportunities, :jobs
    rename_column :applications, :job_opportunity_id, :job_id
  end
end
