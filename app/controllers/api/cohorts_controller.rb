module Api
  class CohortsController < ActionController::Base

    def index
      cohorts = Cohort.where('start_date < :date and end_date > :date', date: Date.today)
      render json: {cohort: cohorts.map{|cohort| {id: cohort.id, name: cohort.name}}}
    end

  end
end
