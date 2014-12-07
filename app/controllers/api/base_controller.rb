module Api
  class BaseController < ActionController::Base
    include UserSessionHelper

    before_action do
      headers['Access-Control-Allow-Origin'] = ENV['EMBER_APP_URL']
      headers['Access-Control-Allow-Credentials'] = 'true'

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
