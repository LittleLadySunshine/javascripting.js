class CreateCurriculums < ActiveRecord::Migration
  def change
    create_table :curriculums do |t|
      t.string :name, null: false
      t.index :name
      t.text :description, null: false
      t.timestamps null: false
    end
  end
end
