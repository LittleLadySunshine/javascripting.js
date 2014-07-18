class Job < ActiveRecord::Base
  belongs_to :company
  has_many :applications
  belongs_to :poster, :class_name => User, :foreign_key => :posted_by_id

  has_many :applicants, :through => :applications, :source => :user

  validates :company, :presence => true
  validates :poster, :presence => true
  def company_name
    company.name
  end

  def self.opportunities_for(user)
    public_clause = arel_table[:visibility].eq("Public")
    posted_by_clause = arel_table[:posted_by_id].eq(user.id)

    where(public_clause.or(posted_by_clause))
  end
end
