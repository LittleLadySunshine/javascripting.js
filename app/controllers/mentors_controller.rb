class MentorsController < SignInRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
    @user = User.find(params[:student_id])
  end

  def index
    @mentors = Mentor.where(user_id: @user)
  end

  def new
    @mentor = Mentor.new
  end

  def create
    @mentor = Mentor.new(mentor_params)
    @mentor.user = @user

    if @mentor.save
      redirect_to(
        cohort_student_mentors_path(@cohort, @user),
        notice: 'Mentor successfully created'
      )
    else
      render :new
    end
  end

  def show
    @mentor = Mentor.where(user_id: @user).find(params[:id])
  end

  def edit
    @mentor = Mentor.where(user_id: @user).find(params[:id])
  end

  def update
    @mentor = Mentor.where(user_id: @user).find(params[:id])

    if @mentor.update(mentor_params)
      redirect_to(
        cohort_student_mentors_path(@cohort, @user),
        notice: 'Mentor successfully updated'
      )
    else
      render :edit
    end
  end

  def destroy
    @mentor = Mentor.where(user_id: @user).find(params[:id])
    @mentor.destroy
    redirect_to(
      cohort_student_mentors_path(@cohort, @user),
      notice: 'Mentor removed successfully'
    )
  end

  private

  def mentor_params
    params.require(:mentor).permit(:first_name, :last_name, :email, :company_name)
  end
end
