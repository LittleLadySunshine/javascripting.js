class CreateAssessmentsAgain < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.belongs_to :user, null: false
      t.belongs_to :rubric, null: false
      t.belongs_to :assessor, null: false
      t.date :date, null: false
      t.json :questions_json, null: false
      t.json :responses_json, null: false
      t.timestamps
    end
  end
end
