class AddRoleBitMaskToUser < ActiveRecord::Migration
  def change
    add_column :users, :role_bit_mask, :integer, :default => 0
  end
end
