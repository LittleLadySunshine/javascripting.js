class CreateStoriesAndUserStories < ActiveRecord::Migration
  def change
    add_column :epics, :label, :string

    create_table :stories do |t|
      t.belongs_to :epic, null: false
      t.string :title, null: false
      t.string :description
      t.integer :position, null: false, default: 0
      t.index [:epic_id, :position], unique: true
      t.index [:epic_id, :title], unique: true
      t.timestamps
    end

    create_table :student_stories do |t|
      t.belongs_to :class_project, null: false
      t.belongs_to :epic, null: false
      t.belongs_to :story, null: false
      t.belongs_to :user, null: false
      t.index [:story_id, :user_id], unique: true
      t.string :current_status, null: false
      t.timestamps
    end
  end
end
