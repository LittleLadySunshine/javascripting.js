class PersonalInformationController < SignInRequiredController

  def edit
    @user = user_session.current_user
  end

  def update
    @user = user_session.current_user

    if @user.update(personal_project_params)
      redirect_to personal_information_path, notice: "Personal information was successfully updated"
    else
      render :edit
    end
  end

  private

  def personal_project_params
    params.require(:user).permit(:phone, :twitter, :linkedin, :blog, :address_1, :address_2, :city, :state, :zip_code, :shirt_size)
  end
end
