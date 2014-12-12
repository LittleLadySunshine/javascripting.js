class PersonalInformationController < SignInRequiredController

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to personal_information_path, notice: "Personal information was successfully updated"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :phone,
      :twitter,
      :linkedin,
      :blog,
      :address_1,
      :address_2,
      :city,
      :state,
      :zip_code,
      :shirt_size,
      :pivotal_tracker_token,
    )
  end
end
