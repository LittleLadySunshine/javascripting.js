class CreateJobOpporunities < ActiveRecord::Migration
  def change
    create_table :job_opportunities do |t|
      t.string :company_name, :null => false
      t.string :company_location
      t.string :contact_name
      t.string :contact_email
      t.string :contact_number
      t.string :salary
      t.string :job_status
      t.string :decision
      t.string :job_title

      t.timestamps
    end
  end
end
