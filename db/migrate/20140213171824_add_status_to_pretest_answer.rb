class AddStatusToPretestAnswer < ActiveRecord::Migration
  def change
    add_column :pre_test_answers, :status, :string, :default => 'ungraded', :null => false
  end
end
