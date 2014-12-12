class UserEpicsController < SignInRequiredController

  before_action do
    @user = User.find(params[:user_id])
  end

  def index
    @epics = Epic.includes(:class_project).group_by(&:class_project)
  end

  def show
    @epic = Epic.find(params[:id])
    @project = StudentProject.where(
      user_id: @user,
      class_project_id: @epic.class_project
    ).first
    @student_stories = StudentStory.where(
      story_id: @epic.stories,
      user_id: @user,
    ).index_by(&:story_id)
  end

  def add_to_tracker
    @epic = Epic.find(params[:id])
    @project = StudentProject.where(
      user_id: @user,
      class_project_id: @epic.class_project
    ).first

    student_stories = StudentStory.where(
      story_id: @epic.stories,
      user_id: @user,
    ).index_by(&:story_id)

    project_id = @project.tracker_url.sub(/https?:\/\/(www\.)?pivotaltracker\.com\/n\/projects\//, '')

    @epic.stories.each do |story|
      unless student_stories[story.id]
        conn = Faraday.new(:url => 'https://www.pivotaltracker.com')

        response = conn.post do |req|
          req.url "/services/v5/projects/#{project_id}/stories"
          req.headers['Content-Type'] = 'application/json'
          req.headers['X-TrackerToken'] = @user.pivotal_tracker_token
          req.body = {
            name: story.title,
            description: story.description,
            story_type: 'feature',
            current_state: 'unstarted',
            estimate: 1,
            labels: [@epic.label, @epic.category].select(&:present?).map{|label| {name: label}},
          }.to_json
        end

        if response.success?
          json = JSON.parse(response.body, symbolize_names: true)
          StudentStory.create!(
            class_project: @epic.class_project,
            user: @user,
            story: story,
            epic: @epic,
            current_state: 'unstarted',
            pivotal_tracker_id: json[:id],
          )
        else
          raise response.inspect
        end
      end
    end

    flash[:notice] = "Stories added"
    redirect_to user_epic_path(@user, @epic)
  end

end
