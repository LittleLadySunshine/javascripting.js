class AddGcampUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gcamp_url, :string
  end
end
