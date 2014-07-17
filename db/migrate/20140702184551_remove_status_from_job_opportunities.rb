class RemoveStatusFromJobOpportunities < ActiveRecord::Migration
  def change
    remove_column :jobs, :status
  end
end
