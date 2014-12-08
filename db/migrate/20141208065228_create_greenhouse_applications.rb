class CreateGreenhouseApplications < ActiveRecord::Migration
  def change
    create_table :greenhouse_applications do |t|
      t.belongs_to :cohort, null: false
      t.json :application_json, null: false
      t.json :candidate_json, null: false
      t.timestamps
    end
  end
end
