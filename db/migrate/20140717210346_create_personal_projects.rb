class CreatePersonalProjects < ActiveRecord::Migration
  def change
    create_table :personal_projects do |t|
      t.string :name
      t.text :description
      t.string :github_repo_name
      t.string :tracker_url
      t.string :production_url
      t.references :user

      t.timestamps
    end
  end
end
