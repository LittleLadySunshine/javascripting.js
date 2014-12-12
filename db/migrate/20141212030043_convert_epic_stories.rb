class ConvertEpicStories < ActiveRecord::Migration

  class MigrationEpic < ActiveRecord::Base
    self.table_name = :epics
  end

  class MigrationStory < ActiveRecord::Base
    self.table_name = :stories
  end

  require 'csv'

  def up
    change_column :stories, :description, :text
    MigrationEpic.reset_column_information
    MigrationStory.reset_column_information
    MigrationStory.delete_all

    MigrationEpic.all.each do |epic|
      if epic.stories?
        stories = CSV.parse(epic.stories, headers: true)
        labels = []
        stories.each_with_index do |story, index|
          MigrationStory.create!(
            epic_id: epic.id,
            title: story['Title'] || story['Story'],
            description: story['Description'],
            position: index,
          )
          labels += story['Labels'].split(",").map(&:strip).reject{|label| %w(mvp stretch).include?(label) }
        end
        epic.update(label: labels.first)
      end
    end
  end
end
