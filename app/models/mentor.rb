class Mentor < ActiveRecord::Base

  belongs_to :user
  validates :user, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

end
