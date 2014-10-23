class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception

  include UserSessionHelper

  def get_home_path
    if user_session.signed_in?
      if user_session.current_user.instructor?
        active_staffings = Staffing.where(user_id: user_session.current_user).active
        if active_staffings.length == 1
          instructor_cohort_path(active_staffings.first.cohort)
        else
          instructor_cohorts_path
        end
      else
        cohort_exercises_path(user_session.current_user.cohort)
      end
    else
      root_path
    end
  end

  helper_method :get_home_path

end
