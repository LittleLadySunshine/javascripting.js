class Student::ActionPlanEntriesController < SignInRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  def index
    user = user_session.current_user

    @entries = ActionPlanEntry.for_cohort_and_user(@cohort, user).order('created_at desc')
  end

end
