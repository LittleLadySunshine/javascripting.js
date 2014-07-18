class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.belongs_to :user, :null => false
      t.string :status, :null => false
      t.string :quiz_name, :null => false
      t.integer :quiz_version, :null => false
      t.timestamps
    end
  end
end
