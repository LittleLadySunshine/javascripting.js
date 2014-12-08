class AddCompaniesToMentors < ActiveRecord::Migration
  def change
    add_column :mentors, :company_name, :string
  end
end
