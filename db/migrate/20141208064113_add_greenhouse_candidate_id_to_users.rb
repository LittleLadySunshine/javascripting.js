class AddGreenhouseCandidateIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :greenhouse_candidate_id, :bigint
    add_index :users, :greenhouse_candidate_id, unique: true
  end
end
