class DropFeedbackEntries < ActiveRecord::Migration
  def change
    drop_table :feedback_entries
  end
end
