class PublicPagesController < ApplicationController

  layout 'public'

  def preparation_index
    @cohorts = Cohort.upcoming
  end

  def preparation
    @cohort = Cohort.find_by_id(params[:id])
  end

end
