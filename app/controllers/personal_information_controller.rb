class PersonalInformationController < SignInRequiredController

  layout 'application_bootstrap'

  def edit
    @user = user_session.current_user
  end

  def update
    @user = user_session.current_user

    if @user.update(personal_project_params)
      flash[:success] = "Personal information was successfully updated"
      redirect_to personal_information_path
    else
      render :edit
    end
  end

  private

  def personal_project_params
    params.require(:user).permit(:phone, :twitter, :linkedin, :blog, :address_1, :address_2, :city, :state, :zip_code, :shirt_size)
  end
end
