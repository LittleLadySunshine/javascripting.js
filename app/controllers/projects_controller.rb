class ProjectsController < SignInRequiredController

  before_action do
    @cohort = Cohort.find_by_id(params[:cohort_id])
    @user = User.find(params[:user_id])
  end

  def index
    @projects = StudentProject.for_user(@user)
  end

  def new
    @project = StudentProject.for_user(@user).new
  end

  def create
    @project = StudentProject.for_user(@user).new(project_params)

    if @project.save
      flash[:notice] = "Project Created"
      redirect_to user_projects_path(@user, cohort_id: params[:cohort_id])
    else
      render :new
    end
  end

  def edit
    @project = StudentProject.for_user(@user).find(params[:id])
  end

  def update
    @project = StudentProject.for_user(@user).find(params[:id])

    if @project.update(project_params)
      flash[:notice] = "Project Saved"
      redirect_to user_projects_path(@user, cohort_id: params[:cohort_id])
    else
      render :edit
    end
  end

  def destroy
    @project = StudentProject.for_user(@user).find(params[:id])
    @project.destroy
    flash[:notice] = "Project Deleted"
    redirect_to user_projects_path(@user, cohort_id: params[:cohort_id])
  end

  private

  def project_params
    params.require(:student_project).permit(
      :name,
      :description,
      :github_url,
      :tracker_url,
      :production_url,
      :technical_notes,
      :screenshot,
      :code_climate,
      :travis,
    )
  end
end
