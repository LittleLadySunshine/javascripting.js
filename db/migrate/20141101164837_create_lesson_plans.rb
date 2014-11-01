class CreateLessonPlans < ActiveRecord::Migration
  def change
    create_table :lesson_plans do |t|
      t.string :name, null: false
      t.index :name, unique: true
      t.text :objectives
      t.text :assessment
      t.text :activity
      t.text :description
      t.timestamps null: false
    end
  end
end
