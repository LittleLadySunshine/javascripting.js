class ApplicationsController < ApplicationController
  def edit
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    update_params = params
      .require(:application)
      .permit(:resume)

    if ApplyForJob.call(@application, update_params)
      flash[:notice] = "You have successfully applied!"
      redirect_to job_dashboard_path
    else
      flash[:error] = "There was a problem applying for the job"
      redirect_to :back
    end
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      flash[:notice] = "Job has been saved to your dashboard"
      redirect_to job_dashboard_path
    else
      flash[:error] = "You already added this job"
      redirect_to :back
    end
  end

  def confirm
    @application = Application.find(params[:application_id])
    if ApplyForJob.call(@application, {})
      flash[:notice] = "You have successfully applied!"
      redirect_to job_dashboard_path
    else
      flash[:error] = "There was a problem applying for the job"
      redirect_to :back
    end
  end

 private

 def application_params
   params.permit(:application).
     permit(:resume).
     merge(
      job_id: params[:job_id],
      user_id: user_session.current_user.id,
    )
 end
end
