class RemoveMyJobOpportunities < ActiveRecord::Migration
  def change
    drop_table :my_job_opportunities
  end
end
