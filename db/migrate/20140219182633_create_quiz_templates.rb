class CreateQuizTemplates < ActiveRecord::Migration
  def change
    drop_table :short_answer_quiz_templates, :force => true
    
    create_table :quiz_templates do |t|
      t.string :name, :null => false
      t.integer :version, :null => false
      t.text :question_text, :null => false
      t.timestamps :null => false
    end

    add_index :quiz_templates, [:name, :version], :unique => true
  end
end
