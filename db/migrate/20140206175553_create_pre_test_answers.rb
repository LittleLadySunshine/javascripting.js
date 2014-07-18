class CreatePreTestAnswers < ActiveRecord::Migration
  def change
    create_table :pre_test_answers do |t|
      t.belongs_to :pre_test, :null => false
      t.integer :question_id, :null => false
      t.text :answer_text
      t.timestamps
    end

    add_index :pre_test_answers, [:pre_test_id, :question_id], :unique => true
  end
end
