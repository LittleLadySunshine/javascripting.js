class Instructor::UsersController < InstructorRequiredController

  before_action do
    @cohort = Cohort.find_by_id(params[:cohort_id])
  end

  def index
    @users = User.order(:first_name, :last_name)
  end

  def new
    @user = User.new
    @user.cohort = @cohort if @cohort
  end

  def create
    @user = User.new(user_params)

    if @user.save
      if @user.student? && params[:send_welcome_email] == '1'
        StudentMailer.invitation(@user.email).deliver
      end
      redirect_to instructor_user_path(@user, cohort_id: params[:cohort_id]), notice: 'User created successfully'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = 'User updated successfully'
      redirect_to instructor_user_path(@user, cohort_id: params[:cohort_id])
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to instructor_users_path, notice: "User was deleted successfully"
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :avatar,
      :role,
      :status,
      :github_username,
      :github_id,
      :cohort_id,
      :phone,
      :twitter,
      :blog,
      :address_1,
      :address_2,
      :city,
      :state,
      :zip_code,
      :linkedin,
      :avatar,
      :shirt_size,
      :greenhouse_candidate_id,
      :pivotal_tracker_token,
    )
  end

end
