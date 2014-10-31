class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.belongs_to :user, null: false
      t.integer :pair_id, null: false
      t.text :feedback, null: false
      t.date :paired_on, null: false
      t.timestamps null: false
      t.index :pair_id
      t.index [:user_id, :pair_id], unique: true
    end
  end
end
