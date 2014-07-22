class AddPairFeedbackLinkToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :pair_feedback_url, :string
  end
end
