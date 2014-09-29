class SessionsController < ApplicationController
  def create
    github_id = request.env['omniauth.auth']['uid']
    github_info = request.env['omniauth.auth']['info'].merge('id' => github_id)

    user = FindAndUpdateUserFromGithubInfo.call(github_info)

    if user.present?
      user_session.sign_in(user)

      notice = I18n.t("welcome_message", :first_name => user.first_name, :last_name => user.last_name)

      if user.is?(User::INSTRUCTOR)
        redirect_to instructor_cohort_path(user.cohort), :notice => notice
      else
        redirect_to student_exercises_path, :notice => notice
      end
    else
      notice = I18n.t('access_denied')
      redirect_to root_path, :notice => notice
    end
  end

  def destroy
    user_session.sign_out
    redirect_to root_path
  end

  def failure
    flash[:alert] = I18n.t("login_failed")
    redirect_to root_path
  end
end
