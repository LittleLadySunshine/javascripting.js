class Instructor::LessonsController < ApplicationController

  before_action do
    @lesson_plan = LessonPlan.find(params[:lesson_plan_id])
  end

  def new
    @lesson = @lesson_plan.lesson.new
  end

  def create
    @lesson = @lesson_plan.lessons.new(params.require(:lesson).permit(:date, :cohort_id, :lesson_plan_id))
    if @lesson.save
      redirect_to instructor_lesson_plan_path(@lesson_plan)
    else
      render :new
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    redirect_to instructor_lesson_plan_path(@lesson_plan)
  end

end
