class AddPostedByToJobOpportunity < ActiveRecord::Migration
  def change
    add_column :job_opportunities, :posted_by_id, :integer
  end
end
