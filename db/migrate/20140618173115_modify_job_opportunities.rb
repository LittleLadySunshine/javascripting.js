class ModifyJobOpportunities < ActiveRecord::Migration
  def change
    remove_column :jobs, :company_name
    remove_column :jobs, :contact_name
    remove_column :jobs, :contact_email
    remove_column :jobs, :contact_number
    rename_column :jobs, :company_location, :location
    add_column :jobs, :company_id, :integer
  end
end
