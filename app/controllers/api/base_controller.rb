module Api
  class BaseController < ActionController::Base
    include UserSessionHelper

    before_action do
      if !user_session.signed_in?
        render nothing: true, status: 403
      end
    end
  end
end
