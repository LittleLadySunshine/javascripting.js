class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception

  include UserSessionHelper

  before_action do
    headers['Access-Control-Allow-Origin'] = ENV['EMBER_APP_URL']
    headers['Access-Control-Allow-Credentials'] = 'true'
  end

  def get_home_path
    if user_session.signed_in?
      if user_session.current_user.instructor?
        active_staffings = Staffing.where(user_id: user_session.current_user).active
        if active_staffings.length == 1
          today_cohort_daily_plans_path(active_staffings.first.cohort)
        else
          instructor_cohorts_path
        end
      else
        today_cohort_daily_plans_path(user_session.current_user.cohort)
      end
    else
      root_path
    end
  end

  helper_method :get_home_path

end
