class CreateDailyPlans < ActiveRecord::Migration
  def change
    create_table :daily_plans do |t|
      t.belongs_to :cohort, null: false
      t.date :date, null: false
      t.index [:date, :cohort_id], unique: true
      t.text :description, null: false
      t.timestamps null: false
    end
  end
end
