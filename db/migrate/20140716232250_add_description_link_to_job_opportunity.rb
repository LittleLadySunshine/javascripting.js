class AddDescriptionLinkToJobOpportunity < ActiveRecord::Migration
  def change
    add_column :job_opportunities, :description_link, :string
  end
end
