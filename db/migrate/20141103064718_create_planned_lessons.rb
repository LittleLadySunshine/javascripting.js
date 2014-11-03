class CreatePlannedLessons < ActiveRecord::Migration
  def change
    create_table :planned_lessons do |t|
      t.belongs_to :curriculum_unit, null: false
      t.belongs_to :lesson_plan, null: false
      t.integer :position, null: false
      t.index [:curriculum_unit_id, :lesson_plan_id], unique: true
      t.index [:curriculum_unit_id, :position], unique: true
      t.timestamps null: false
    end
  end
end
