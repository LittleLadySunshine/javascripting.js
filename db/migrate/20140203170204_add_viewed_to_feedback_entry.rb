class AddViewedToFeedbackEntry < ActiveRecord::Migration
  def change
    add_column :feedback_entries, :viewed, :boolean, :default => false
  end
end
