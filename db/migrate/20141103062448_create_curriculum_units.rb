class CreateCurriculumUnits < ActiveRecord::Migration
  def change
    create_table :curriculum_units do |t|
      t.belongs_to :cohort, null: false
      t.string :name, null: false
      t.index [:name, :cohort_id], unique: true
      t.integer :position, null: false
      t.index [:position, :cohort_id], unique: true
      t.text :objectives, null: false
      t.text :assessment, null: false
      t.text :essential_questions
      t.text :rationale
      t.text :activities
      t.timestamps null: false
    end
  end
end
