class CreatePreTestQuestions < ActiveRecord::Migration
  def change
    create_table :pre_test_questions do |t|
      t.text :text, :null => false
    end
  end
end
