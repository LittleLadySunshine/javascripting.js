class AddShowEmploymentRibbonToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :show_employment_ribbon, :boolean, default: false, null: false
    execute "update cohorts set show_employment_ribbon = true"
  end
end
