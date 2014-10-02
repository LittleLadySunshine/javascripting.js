class RenameRoleBitMask < ActiveRecord::Migration
  def change
    rename_column :users, :role_bit_mask, :role
  end
end
