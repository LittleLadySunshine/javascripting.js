class AddQuestionIndexToAnswers < ActiveRecord::Migration
  def change
    execute 'delete from quizzes;'
    execute 'delete from quiz_answers;'
    add_column :quiz_answers, :question_index, :integer, :null => false
  end
end
