class GreenhouseApplication < ActiveRecord::Base

  belongs_to :cohort

  validates :cohort, presence: true
  validates :application_json, presence: true
  validates :candidate_json, presence: true

  def full_name
    "#{candidate_json['first_name']} #{candidate_json['last_name']}"
  end

  def candidate_id
    candidate_json['id']
  end

  def email
    candidate_json['email_addresses'].first.try(:[], 'value')
  end

  def phone
    candidate_json['phone_numbers'].first.try(:[], 'value')
  end

  def urls
    urls = candidate_json['website_addresses'] .map{|info| info['value']}
    urls += candidate_json['social_media_addresses'] .map{|info| info['value'] }
    urls.select{|value| value.starts_with?('http')}
  end

end
