class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.belongs_to :student, :null => false
      t.integer :score, :null => false, :default => 0

      t.timestamps
    end

    add_index :rankings, :student_id, :unique => true
    add_index :rankings, :score
  end
end
