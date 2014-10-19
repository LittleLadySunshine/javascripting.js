class Student::ClassNotesController < SignInRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  class ClassNote
    attr_reader :date

    def initialize(github_data)
      @github_data = github_data
      @date = @github_data[:name].sub('.md', '').to_date
    end

    def to_param
      date.strftime("%Y-%m-%d")
    end

    def past?
      date < Date.today
    end

    def today?
      date == Date.today
    end

    def css_class
      if today?
        "text-danger"
      elsif past?
        "text-muted"
      end
    end
  end

  def today
    redirect_to cohort_class_note_path(@cohort, Date.today.strftime("%Y-%m-%d"))
  end

  def index
    client = Octokit::Client.new(access_token: session[:access_token])
    results = client.contents('gSchool/boulder-g4-assets', path: "class-notes")
    @days = results.map{|result| ClassNote.new(result) }

    result = []
    @days.group_by{|day| day.date.strftime("%U") }.each.with_index(1) do |(_, days), week_number|
      result << [week_number, days.sort_by(&:date)]
    end

    @days = result.reverse
  end

  def show
    client = Octokit::Client.new(access_token: session[:access_token])

    @date = params[:id].to_date
    begin
      @content = client.contents(
        'gSchool/boulder-g4-assets',
        path: "class-notes/#{@date.strftime("%Y-%m-%d")}.md",
        accept: "application/vnd.github.VERSION.html"
      )
    rescue Octokit::NotFound => e
    end
  end

end
