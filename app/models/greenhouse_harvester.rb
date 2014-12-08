class GreenhouseHarvester

  def initialize(cohort, api_key = ENV['GREENHOUSE_HARVEST_API_KEY'])
    @cohort = cohort
    @api_key = api_key
  end

  def harvest
    conn = Faraday.new(:url => 'https://harvest.greenhouse.io')
    conn.basic_auth(@api_key, '')

    response = conn.get do |req|
      req.url "/v1/applications"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = TRACKER_TOKEN
    end

    response_json = JSON.parse(response.body, symbolize_names: true)

    applications = {}
    response_json.each do |application|
      job_ids = application[:jobs].map{|job| job[:id] }
      if job_ids.include?(@cohort.greenhouse_job_id) && application[:status] == "hired"
        applications[application[:candidate_id]] = {application: application}
      end
    end

    records = []
    applications.each do |candidate_id, info|
      response = conn.get do |req|
        req.url "/v1/candidates/#{candidate_id}"
      end

      response_json = JSON.parse(response.body, symbolize_names: true)
      records << GreenhouseApplication.new(
        cohort: @cohort,
        application_json: info[:application],
        candidate_json: response_json
      )
    end

    GreenhouseApplication.transaction do
      GreenhouseApplication.where(cohort_id: @cohort).delete_all
      records.each(&:save!)
    end
  end

end
