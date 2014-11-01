class CreateWriteups < ActiveRecord::Migration
  def change
    create_table :writeup_topics do |t|
      t.belongs_to :cohort, null: false
      t.string :subject, null: false
      t.text :description
      t.boolean :active, null: false, default: true
      t.timestamps null: false
    end

    create_table :writeups do |t|
      t.belongs_to :writeup_topic, null: false
      t.belongs_to :user, null: false
      t.text :response, null: false
      t.boolean :read, null: false, default: false
      t.timestamps null: false
      t.index [:writeup_topic_id, :user_id]
    end
  end
end
