class CreateStaffings < ActiveRecord::Migration
  def change
    create_table :staffings do |t|
      t.belongs_to :cohort, null: false
      t.belongs_to :user, null: false
      t.integer :status, null: false
      t.index :status
      t.index [:cohort_id, :user_id], unique: true
      t.timestamps null: false
    end
  end
end
