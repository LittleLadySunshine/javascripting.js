class CreateTrackerStatuses < ActiveRecord::Migration
  def change
    create_table :tracker_statuses do |t|
      t.belongs_to :user, null: false
      t.integer :delivered, null: false, default: 0
      t.integer :accepted, null: false, default: 0
      t.integer :rejected, null: false, default: 0
      t.integer :started, null: false, default: 0
      t.integer :finished, null: false, default: 0
      t.integer :unstarted, null: false, default: 0
      t.integer :unscheduled, null: false, default: 0
      t.timestamps null: false
      t.index :user_id, unique: true
    end
  end
end
