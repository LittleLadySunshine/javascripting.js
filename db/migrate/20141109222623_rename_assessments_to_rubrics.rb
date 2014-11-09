class RenameAssessmentsToRubrics < ActiveRecord::Migration
  def change
    create_table :rubrics do |t|
      t.string :name, null: false
      t.index :name, unique: true
      t.json :questions_json, null: false
      t.timestamps
    end
    drop_table :assessments
  end
end
