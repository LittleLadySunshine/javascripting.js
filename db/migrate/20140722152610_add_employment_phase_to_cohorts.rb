class AddEmploymentPhaseToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :employment_phase, :boolean, :null => false, :default => false
  end
end
