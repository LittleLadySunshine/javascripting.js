class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.belongs_to :cohort
      t.belongs_to :lesson_plan
      t.date :date
      t.timestamps
    end
  end
end
