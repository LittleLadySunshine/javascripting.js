class RemoveUserAndDecisionFromJobOpportunities < ActiveRecord::Migration
  def change
    remove_column :jobs, :decision
    remove_column :jobs, :user_id
  end
end
