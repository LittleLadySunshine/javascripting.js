class ChangeJobOpportunityStatusToVisibility < ActiveRecord::Migration
  def change
    rename_column :job_opportunities, :job_status, :visibility
  end
end
