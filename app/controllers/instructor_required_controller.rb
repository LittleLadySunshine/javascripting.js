class InstructorRequiredController < SignInRequiredController
  before_action :require_instructor

  protected

  def require_instructor
    unless current_user.instructor?
      redirect_to root_path
    end
  end
end
