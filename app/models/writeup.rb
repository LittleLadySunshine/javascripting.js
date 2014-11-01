class Writeup < ActiveRecord::Base

  belongs_to :user
  belongs_to :writeup_topic

  validates :user, presence: true
  validates :writeup_topic, presence: true, uniqueness: {scope: :user_id}

end
