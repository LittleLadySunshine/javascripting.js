class RenameJobOpportunities < ActiveRecord::Migration
  def change
    rename_table :jobs, :job_opportunities
    rename_column :applications, :job_opportunity_id, :job_id
  end
end
