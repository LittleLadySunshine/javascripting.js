class RemoveCurriculumSiteUrl < ActiveRecord::Migration
  def change
    remove_column :cohorts, :curriculum_site_url
  end
end
