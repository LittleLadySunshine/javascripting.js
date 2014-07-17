class AddDescriptionLinkToJobOpportunity < ActiveRecord::Migration
  def change
    add_column :jobs, :description_link, :string
  end
end
