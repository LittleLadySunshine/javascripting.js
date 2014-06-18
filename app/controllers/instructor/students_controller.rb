class Instructor::StudentsController < InstructorRequiredController
  def new
    @student = User.new
  end

  def create
    @student = User.new(student_params)

    if @student.save
      flash[:notice] = 'Student added successfully'
      StudentMailer.invitation(@student.email).deliver
      redirect_to instructor_cohort_path(params[:cohort_id])
    else
      render :new
    end
  end

  def show
    @student = User.find(params[:id])
  end

  def edit
    @student = User.find(params[:id])
  end

  def update
    @student = User.find(params[:id])

    if @student.update(student_params)
      flash[:notice] = 'Student updated successfully'
      redirect_to instructor_cohort_path(params[:cohort_id])
    else
      render :edit
    end
  end

  private

  def student_params
    params.require(:student)
          .permit(:first_name, :last_name, :email, :avatar)
          .merge(cohort_id: params[:cohort_id])
  end
end
