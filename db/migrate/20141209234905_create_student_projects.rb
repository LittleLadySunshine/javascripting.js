class CreateStudentProjects < ActiveRecord::Migration
  def change
    create_table :student_projects do |t|
      t.belongs_to :user, null: false
      t.string   :name, null: false
      t.text     :description
      t.string   :github_url
      t.string   :tracker_url
      t.string   :production_url
      t.string   :screenshot
      t.boolean   :code_climate, null: false, default: false
      t.boolean   :travis, null: false, default: false
      t.text   :technical_notes
      t.timestamps
    end
  end
end
