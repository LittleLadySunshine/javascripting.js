module Api
  class BaseController < ActionController::Base
    include UserSessionHelper

    before_action do
      response.headers['Access-Control-Allow-Origin'] = ENV['EMBER_URL']
      response.headers['Access-Control-Allow-Credentials'] = true

      if !user_session.signed_in?
        render nothing: true, status: 403
      end
    end
  end
end
