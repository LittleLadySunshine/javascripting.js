class CreateMyJobOpportunities < ActiveRecord::Migration
  def change
    create_table :my_jobs do |t|
      t.integer :job_opportunity_id
      t.integer :user_id
      t.integer :role

      t.timestamps
    end
    add_index :my_jobs, :job_opportunity_id
    add_index :my_jobs, :user_id
  end
end
