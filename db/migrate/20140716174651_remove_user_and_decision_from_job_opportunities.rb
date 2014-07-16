class RemoveUserAndDecisionFromJobOpportunities < ActiveRecord::Migration
  def change
    remove_column :job_opportunities, :decision
    remove_column :job_opportunities, :user_id
  end
end
