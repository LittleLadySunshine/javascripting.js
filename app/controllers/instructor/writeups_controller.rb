class Instructor::WriteupsController < InstructorRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  def update
    @writeup_topic = @cohort.writeup_topics.find(params[:writeup_topic_id])
    @writeup = @writeup_topic.writeups.find(params[:id])
    @writeup.update(read: true)
    render nothing: true
  end

  private

  def writeup_topic_params
    params.require(:writeup_topic).permit(:subject, :description, :active)
  end

end
