class CreateEpics < ActiveRecord::Migration
  def change
    create_table :epics do |t|
      t.belongs_to :class_project, null: false
      t.integer :category, null: false, default: 0
      t.string :name, null: false
      t.index [:class_project_id, :name, :category], unique: true, name: :index_category_epic_name
      t.integer :position, null: false
      t.index [:class_project_id, :position], unique: true
      t.text :stories
      t.text :wireframes
      t.timestamps null: false
    end

    execute <<-SQL
      insert into epics (class_project_id, category, name, position, stories, wireframes, created_at, updated_at)
      select class_project_id, category, name, position, stories, wireframes, created_at, updated_at
      from class_project_features
    SQL
  end
end
