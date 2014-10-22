class AddStatusToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :status, :integer, :null => false, :default => 0
  end
end
