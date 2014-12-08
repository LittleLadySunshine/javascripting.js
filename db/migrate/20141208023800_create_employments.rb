class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.belongs_to :user, null: false
      t.string :company_name, null: false
      t.string :city
      t.string :company_type
      t.boolean :active, default: true, null: false
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
        insert into employments (user_id, company_name)
          select id, employer
          from users
          where employer is not null and trim(employer) != ''
          SQL
        end
    end
  end
end
