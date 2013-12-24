class SessionsController < ApplicationController
  def create
    github_id = request.env['omniauth.auth']['uid']
    github_info = request.env['omniauth.auth']['info'].merge('id' => github_id)

    user = FindUserFromGithubInfo.call(github_info)

    if user.present?
      user_session.sign_in(user)
      user.update_attributes(github_username: github_info['nickname']) unless user.github_username.present?
      notice = I18n.t("welcome_message", first_name: user.first_name, last_name: user.last_name)
      redirect_to dashboard_path, notice: notice
    else
      notice = I18n.t('access_denied')
      redirect_to root_path, notice: notice
    end
  end

  def destroy
    user_session.sign_out
    redirect_to root_path
  end

  def failure
    flash[:error] = I18n.t("login_failed")
    redirect_to root_path
  end
end

