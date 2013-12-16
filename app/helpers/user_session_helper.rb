module UserSessionHelper
  def user_session
    @user_session ||= UserSession.new(session)
  end

  def require_signed_in_user
    if !user_session.signed_in?
      flash[:notice] = I18n.t('signed_in_user_required_for_page')
      redirect_to root_url
    end
  end
end