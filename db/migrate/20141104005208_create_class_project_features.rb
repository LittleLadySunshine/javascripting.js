class CreateClassProjectFeatures < ActiveRecord::Migration
  def change
    create_table :class_project_features do |t|
      t.belongs_to :class_project, null: false
      t.integer :category, null: false, default: 0
      t.string :name, null: false
      t.index [:class_project_id, :name, :category], unique: true, name: :index_category_feature_name
      t.integer :position, null: false
      t.index [:class_project_id, :position], unique: true
      t.text :stories
      t.text :wireframes
      t.timestamps null: false
    end
  end
end
