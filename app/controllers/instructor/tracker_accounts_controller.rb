class Instructor::TrackerAccountsController < InstructorRequiredController

  layout 'application_bootstrap'

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  def index
    conn = Faraday.new(:url => 'https://www.pivotaltracker.com')

    response = conn.get do |req|
      req.url "/services/v5/accounts/#{ACCOUNT_ID}/memberships"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = TRACKER_TOKEN
    end

    @members = JSON.parse(response.body, symbolize_names: true)
    @students = User.for_cohort(@cohort)
  end

  def create
    conn = Faraday.new(:url => 'https://www.pivotaltracker.com')

    response = conn.get do |req|
      req.url "/services/v5/accounts/#{ACCOUNT_ID}/memberships"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = TRACKER_TOKEN
    end

    @members = JSON.parse(response.body, symbolize_names: true)
    @students = User.for_cohort(@cohort)
    member_emails = @members.map{|membership| membership[:person][:email].downcase }
    @students.each do |student|
      member = member_emails.include?(student.email.downcase)
      unless member
        conn.post do |req|
          req.url "/services/v5/accounts/#{ACCOUNT_ID}/memberships"
          req.headers['Content-Type'] = 'application/json'
          req.headers['X-TrackerToken'] = TRACKER_TOKEN
          req.body = {
            email: student.email,
            initials: student.first_name[0] + student.last_name[0],
            name: student.full_name,
            admin: true,
            project_creator: true,
          }.to_json
        end
      end
    end

    redirect_to instructor_cohort_tracker_accounts_path, notice: "Tracker accounts were created successfully"
  end

end
