class QuizAnswers < ActiveRecord::Migration
  def change
    create_table :quiz_answers do |t|
      t.string :status, :null => false
      t.belongs_to :user, :null => false
      t.belongs_to :quiz, :null => false
      t.string :question, :null => false
      t.text :text
      t.timestamps
    end
  end
end
