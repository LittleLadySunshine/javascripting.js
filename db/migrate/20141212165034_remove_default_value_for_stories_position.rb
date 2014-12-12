class RemoveDefaultValueForStoriesPosition < ActiveRecord::Migration
  def change
    change_column_default :stories, :position, nil
  end
end
