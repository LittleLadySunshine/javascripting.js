module Api
  class BaseController < ActionController::Base
    include UserSessionHelper

    before_action do
      if !user_session.signed_in?
        render nothing: true, status: :unauthorized
      end
    end

    def me
      head :ok
      expires_now
    end
  end
end
