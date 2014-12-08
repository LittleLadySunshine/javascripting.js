class AddSetupFieldsToCohort < ActiveRecord::Migration
  def change
    change_table :cohorts do |t|
      t.string :calendar_url, limit: 1000
      t.text :prereqs
    end
  end
end
