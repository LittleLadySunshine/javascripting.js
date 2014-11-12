class CreateMentors < ActiveRecord::Migration
  def change
    create_table :mentors do |t|
      t.belongs_to :user, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.timestamps
    end
  end
end
