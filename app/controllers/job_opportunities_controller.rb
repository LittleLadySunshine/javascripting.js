class JobOpportunitiesController < ApplicationController
  def index
    job_opportunities = JobOpportunity.all
    render :index, locals: {job_opportunities: job_opportunities}
  end

  def create
    job_parameters = params.require(:job_opportunity).permit!
    job_opportunity = JobOpportunity.new(job_parameters)
    job_opportunity.user_id = user_session.current_user.id
    if job_opportunity.save
      flash[:notice] = 'Job Opportunity Successfully Created'
    else
      flash[:notice] = 'Sorry, something went wrong!'
    end
    redirect_to action: :index
  end

  def show
    job_opportunity = JobOpportunity.find(params[:id])
    render 'show', locals: {
      job_opportunity: job_opportunity
    }
  end

  def edit
    job_opportunity = JobOpportunity.find(params[:id])
    render 'edit', locals: {
      job_opportunity: job_opportunity
    }
  end

  def update
    job_opportunity = JobOpportunity.find(params[:id])
    job_parameters = params.require(:job_opportunity).permit!
    job_opportunity.update(job_parameters)
    redirect_to action: :show
  end

  def destroy
    job_opportunity = JobOpportunity.find(params[:id])
    job_opportunity.destroy
    redirect_to action: :index
  end

  def job_dashboard
    applications = user_session.current_user.applications
    @jobs_to_apply_for = applications.where("status = ?", Application.statuses[:pending]).joins(:job_opportunity)
    @jobs_applied_for = applications.where("status = ?", Application.statuses[:applied]).joins(:job_opportunity)
  end

  def admin_dashboard
    all_jobs = @job_opportunities = JobOpportunity.all
    if user_session.current_user.is?(User::INSTRUCTOR)
      all_jobs
    else
      redirect_to root_path
      flash[:notice] = 'You are not allowed to access this page'
    end
  end
end
