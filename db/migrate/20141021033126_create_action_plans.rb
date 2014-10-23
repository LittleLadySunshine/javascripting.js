class CreateActionPlans < ActiveRecord::Migration
  def change
    create_table :action_plan_entries do |t|
      t.belongs_to :user, null: false
      t.belongs_to :cohort, null: false
      t.text :description
      t.timestamps null: false
    end
  end
end
