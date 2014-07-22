class JobsController < ApplicationController
  def index
    jobs = Job.opportunities_for(user_session.current_user)
    render :index, :locals => {:jobs => jobs}
  end

  def create
    job_parameters = params
      .require(:job)
      .permit!
      .merge(:posted_by_id => user_session.current_user.id)

    job = Job.new(job_parameters)
    job.poster = user_session.current_user
    if job.save
      flash[:notice] = 'Job Opportunity Successfully Created'
    else
      flash[:notice] = 'Sorry, something went wrong!'
    end
    redirect_to :action => :index
  end

  def show
    job = Job.find(params[:id])
    render 'show', :locals => {
      :job => job
    }
  end

  def destroy
    job = Job.find(params[:id])
    job.destroy
    redirect_to :action => :index
  end

  def job_dashboard
    @pending_applications = user_session.current_user.pending_applications
    @completed_applications = user_session.current_user.completed_applications
  end

  def admin_dashboard
    all_jobs = @jobs = Job.all
    if user_session.current_user.is?(User::INSTRUCTOR)
      all_jobs
    else
      redirect_to root_path
      flash[:notice] = 'You are not allowed to access this page'
    end
  end
end
