class RemoveMyJobOpportunities < ActiveRecord::Migration
  def change
    drop_table :my_jobs
  end
end
