namespace :tracker do

  desc "Populates the tracker statuses"
  task populate: :environment do
    students = User.for_cohort(Cohort.current).select(&:gcamp_tracker_url?)

    responses = {}

    students.each do |user|
      url = user.gcamp_tracker_url
      puts "Downloading stories for #{user.full_name}..."
      project_id = url.sub(/https?:\/\/www\.pivotaltracker\.com\/n\/projects\//, '')
      if project_id.present? && project_id =~ /\A\d+$/
        conn = Faraday.new(:url => 'https://www.pivotaltracker.com')

        response = conn.get do |req|
          req.url "/services/v5/projects/#{project_id}/stories?limit=500&offset=0"
          req.headers['Content-Type'] = 'application/json'
          req.headers['X-TrackerToken'] = TRACKER_TOKEN
        end

        if response.success?
          response_json = JSON.parse(response.body, symbolize_names: true)
          responses[user] = response_json
        end
      else
        puts "  Invalid project id for #{user.full_name} / #{url}"
      end
      sleep 0.04
    end

    summaries = {}
    responses.each do |user, stories|
      summaries[user] = {}
      stories.each do |story|
        summaries[user][story[:current_state]] ||= []
        summaries[user][story[:current_state]] << story
      end
    end

    TrackerStatus.delete_all
    summaries.each do |user, totals|
      TrackerStatus.create!(
        user: user,
        delivered: totals.fetch('delivered', []).length,
        accepted: totals.fetch('accepted', []).length,
        rejected: totals.fetch('rejected', []).length,
        finished: totals.fetch('finished', []).length,
        unstarted: totals.fetch('unstarted', []).length,
        started: totals.fetch('started', []).length,
        unscheduled: totals.fetch('unscheduled', []).length,
      )
    end

  end

end
