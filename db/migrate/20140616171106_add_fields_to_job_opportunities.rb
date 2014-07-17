class AddFieldsToJobOpportunities < ActiveRecord::Migration
  def change
    add_column :jobs, :application_due_date, :string
    add_column :jobs, :application_type, :string
    add_column :jobs, :status, :string
  end
end
