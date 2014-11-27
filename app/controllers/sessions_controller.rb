class SessionsController < ApplicationController
  def create
    if request.env['omniauth.params']['src'] == 'ember'
      redirect_to ENV['EMBER_APP_URL']
    else
      github_id = request.env['omniauth.auth']['uid']
      github_info = request.env['omniauth.auth']['info'].merge('id' => github_id)

      user = FindAndUpdateUserFromGithubInfo.call(github_info)

      if user.present?
        session[:access_token] = request.env['omniauth.auth']['credentials']['token']
        user_session.sign_in(user)
        notice = I18n.t("welcome_message", :first_name => user.first_name, :last_name => user.last_name)
        redirect_to get_home_path, :notice => notice
      else
        notice = I18n.t('access_denied')
        redirect_to root_path, :notice => notice
      end
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
