class RemoveStatusFromJobOpportunities < ActiveRecord::Migration
  def change
    remove_column :job_opportunities, :status
  end
end
