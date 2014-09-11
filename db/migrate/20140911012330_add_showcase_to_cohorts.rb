class AddShowcaseToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :showcase, :boolean, :default => false, :null => false
  end
end
