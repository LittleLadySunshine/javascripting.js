class AddPostedByToJobOpportunity < ActiveRecord::Migration
  def change
    add_column :jobs, :posted_by_id, :integer
  end
end
