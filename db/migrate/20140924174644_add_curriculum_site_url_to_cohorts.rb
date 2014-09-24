class AddCurriculumSiteUrlToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :curriculum_site_url, :string
    execute "update cohorts set curriculum_site_url = 'https://github.com/gSchool/curriculum-2014-denver'"
    change_column :cohorts, :curriculum_site_url, :string, null: false
  end
end
