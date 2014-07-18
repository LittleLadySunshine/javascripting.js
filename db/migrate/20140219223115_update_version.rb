class UpdateVersion < ActiveRecord::Migration
  def change
    create_table :quizzes, :force => true do |t|
      t.belongs_to :user, :null => false
      t.string :status, :null => false
      t.string :quiz_name, :null => false
      t.string :quiz_uuid, :null => false
      t.timestamps :null => false
    end

    create_table :quiz_templates, :force => true do |t|
      t.string :name, :null => false
      t.string :uuid, :null => false
      t.text :question_text, :null => false
      t.timestamps :null => false
    end
  end
end
