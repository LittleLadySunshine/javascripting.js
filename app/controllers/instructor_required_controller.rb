class InstructorRequiredController < SignInRequiredController
  before_action :require_instructor

  protected

  def require_instructor
    unless user_session.current_user.instructor?
      redirect_to root_path
    end
  end
end
