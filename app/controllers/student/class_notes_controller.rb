class Student::ClassNotesController < SignInRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  def index
    client = Octokit::Client.new(access_token: session[:access_token])

    @date = Date.today
    begin
      @content = client.contents(
        'gSchool/boulder-g4-assets',
        path: "class-notes/class-notes-#{@date.strftime("%Y-%m-%d")}.md",
        accept: "application/vnd.github.VERSION.html"
      )
    rescue Octokit::NotFound => e
    end
  end

end
