class Student::PersonalProjectsController < SignInRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  def show
    @personal_project = user_session.current_user.personal_project
    redirect_to(:action => :edit) unless @personal_project.present?
  end

  def edit
    user = user_session.current_user
    @personal_project = PersonalProject.find_or_initialize_by(:user_id => user.id)
    @personal_project.save unless @personal_project.persisted?
  end

  def update
    user = user_session.current_user
    @personal_project = PersonalProject.find_or_initialize_by(:user_id => user.id)

    if @personal_project.update(personal_project_params)
      flash[:notice] = "Personal Project Saved"
      redirect_to cohort_personal_project_path(@cohort)
    else
      render :edit
    end
  end

  private

  def personal_project_params
    params.require(:personal_project).
      permit(:name, :description, :github_repo_name, :tracker_url, :production_url)
  end
end
