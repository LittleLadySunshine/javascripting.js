module Instructor
  class EmploymentsController < InstructorRequiredController

    before_action do
      @cohort = Cohort.find_by_id(params[:cohort_id])
      @user = User.find(params[:user_id])
    end

    def new
      @employment = Employment.new
    end

    def create
      @employment = Employment.new(employment_params)
      @employment.user = @user
      if @employment.save
        redirect_to(
          instructor_user_path(@user, cohort_id: params[:cohort_id]),
          notice: "Employment added successfully"
        )
      else
        render :new
      end
    end

    def edit
      @employment = Employment.find(params[:id])
    end

    def update
      @employment = Employment.find(params[:id])
      if @employment.update(employment_params)
        redirect_to(
          instructor_user_path(@user, cohort_id: params[:cohort_id]),
          notice: "Employment was updated"
        )
      else
        render :edit
      end
    end

    def destroy
      @employment = Employment.find(params[:id])
      @employment.destroy
      redirect_to(
        instructor_user_path(@user, cohort_id: params[:cohort_id]),
        notice: 'Employment was deleted'
      )
    end

    private

    def employment_params
      params.require(:employment).permit(:company_name, :city, :company_type, :active)
    end

  end
end
