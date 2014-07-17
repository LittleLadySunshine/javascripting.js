class AddUserToJobOpportunity < ActiveRecord::Migration
  def change
    add_column :job_opportunities, :user_id, :integer
  end
end
