class CreateClassProjects < ActiveRecord::Migration
  def change
    create_table :class_projects do |t|
      t.string :name, null: false
      t.index :name, unique: true
      t.timestamps null: false
    end
  end
end
