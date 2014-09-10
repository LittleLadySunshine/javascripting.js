class AddHeroToCohort < ActiveRecord::Migration
  def change
    add_column :cohorts, :hero, :string
  end
end
