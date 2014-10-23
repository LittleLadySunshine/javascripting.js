class AddGCampTrackerUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gcamp_tracker_url, :string, null: true
  end
end
