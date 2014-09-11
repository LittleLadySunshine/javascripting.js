class ShowcasesController < ApplicationController
  def index
    @cohorts = Cohort.where(:showcase => true).order(:start_date)
  end

  def show
    @cohort = Cohort.find(params[:id])
  end
end