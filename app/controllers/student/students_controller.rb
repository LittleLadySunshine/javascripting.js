class Student::StudentsController < SignInRequiredController
  def index
    @students = user_session.current_cohort.students
  end

  def show
    @student = User.find(params[:id])
  end

  def edit
    @student = User.find(params[:id])
  end

end
