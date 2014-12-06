module Api
  class CohortsController < BaseController

    def index
      render json: Cohort.current
    end

  end
end
