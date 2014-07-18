class CreatePreTests < ActiveRecord::Migration
  def up
    create_table :pre_tests do |t|
      t.belongs_to :user, :null => false
      t.boolean :submitted, :default => false, :null => false

      t.timestamps
    end

    add_index :pre_tests, :user_id, :unique => true
  end

  def down
    drop_table :pre_tests
  end
end
