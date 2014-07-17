class ChangeJobOpportunityStatusToVisibility < ActiveRecord::Migration
  def change
    rename_column :jobs, :job_status, :visibility
  end
end
