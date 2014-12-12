class ConvertEpicStories < ActiveRecord::Migration
  def up
    change_column :stories, :description, :text
  end
end
