class PivotalTrackerHarvester

  def initialize(cohort, sleep = 0.04)
    @cohort = cohort
    @sleep = sleep
  end

  def harvest
    students = User.for_cohort(@cohort)
    projects = StudentProject.where(user_id: students).group_by(&:user_id)
    responses = {}

    students.each do |user|
      projects[user.id].each do |project|
        url = project.tracker_url.to_s
        project_id = url.sub(/https?:\/\/(www\.)?pivotaltracker\.com\/n\/projects\//, '')
        if project_id.present? && project_id =~ /\A\d+$/
          puts "Downloading stories for #{user.full_name}..."
          conn = Faraday.new(:url => 'https://www.pivotaltracker.com')

          response = conn.get do |req|
            req.url "/services/v5/projects/#{project_id}/stories?limit=500&offset=0"
            req.headers['Content-Type'] = 'application/json'
            req.headers['X-TrackerToken'] = TRACKER_TOKEN
          end

          if response.success?
            response_json = JSON.parse(response.body, symbolize_names: true)
            responses[user] ||= {}
            responses[user][project.class_project] = response_json
          end
        else
          puts "  Invalid project id for #{user.full_name} / #{url}"
        end
        sleep @sleep
      end
    end

    summaries = {}
    responses.each do |user, class_projects|
      summaries[user] ||= {}
      class_projects.each do |class_project, stories|
        summaries[user][class_project] = {}
        stories.each do |story|
          summaries[user][class_project][story[:current_state]] ||= []
          summaries[user][class_project][story[:current_state]] << story
        end
      end
    end

    TrackerStatus.where(user_id: students).delete_all
    summaries.each do |user, class_projects|
      class_projects.each do |class_project, totals|
        TrackerStatus.create!(
        user: user,
        class_project: class_project,
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
end
