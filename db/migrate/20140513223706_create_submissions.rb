class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :user, :index => true
      t.references :assignment, :index => true
      t.string :github_repo_name

      t.timestamps
    end
  end
end
