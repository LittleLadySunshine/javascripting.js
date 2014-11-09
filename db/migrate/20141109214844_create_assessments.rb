class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.string :name, null: false
      t.index :name, unique: true
      t.json :questions_json, null: false
      t.timestamps
    end
  end
end
