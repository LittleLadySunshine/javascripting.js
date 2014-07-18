class ReplaceQuizUuidWithTemplateId < ActiveRecord::Migration
  def change
    remove_column :quizzes, :quiz_uuid
    remove_column :quizzes, :quiz_name
    add_column :quizzes, :quiz_template_id, :integer, :null => false
    remove_column :quiz_templates, :uuid
  end
end
