class CompaniesController < ApplicationController
  def new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:notice] = "You successfully added a new company!"
      redirect_to jobs_path
    else
      render :new
      flash[:notice] = "Something went wrong. Please try again."
    end
  end

  private

  def company_params
    params.require(:company).permit!
  end
end
