class AddFieldsToJobOpportunities < ActiveRecord::Migration
  def change
    add_column :job_opportunities, :application_due_date, :string
    add_column :job_opportunities, :application_type, :string
    add_column :job_opportunities, :status, :string
  end
end
