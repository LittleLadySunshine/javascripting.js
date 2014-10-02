class DropAttendances < ActiveRecord::Migration
  def up
    drop_table :attendances
    drop_table :attendance_sheets
  end
end
