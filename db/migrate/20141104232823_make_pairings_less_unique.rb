class MakePairingsLessUnique < ActiveRecord::Migration
  def change
    remove_index :pairings, [:user_id, :pair_id]
    add_index :pairings, [:user_id, :pair_id, :paired_on]
  end
end
