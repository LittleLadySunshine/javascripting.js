class CreateMyJobOpportunities < ActiveRecord::Migration
  def change
    create_table :my_job_opportunities do |t|
      t.integer :job_opportunity_id
      t.integer :user_id
      t.integer :role

      t.timestamps
    end
    add_index :my_job_opportunities, :job_opportunity_id
    add_index :my_job_opportunities, :user_id
  end
end
