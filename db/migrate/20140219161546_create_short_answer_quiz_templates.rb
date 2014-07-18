class CreateShortAnswerQuizTemplates < ActiveRecord::Migration
  def up
    create_table :short_answer_quiz_templates, :force => true do |t|
      t.string :name, :null => false
      t.integer :version, :null => false
      t.text :question_text, :null => false
      t.timestamps :null => false
    end
    
    add_index :short_answer_quiz_templates, [:name, :version], :unique => true
  end
end
