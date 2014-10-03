class Instructor::UsersController < InstructorRequiredController

  def index
    @users = User.order(:first_name, :last_name)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to instructor_users_path, notice: 'User created successfully'
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
      redirect_to instructor_user_path(@user)
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
    )
  end

end