class DailyPlansController < ApplicationController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  before_action except: [:index, :show, :today] do
    authorize!(:manage, :daily_plans)
  end

  def index
    @grouped_plans = DailyPlan.grouped_by_week(@cohort)
  end

  def new
    @daily_plan = DailyPlan.new
  end

  def create
    @daily_plan = DailyPlan.new(daily_plan_params)
    @daily_plan.cohort = @cohort

    if @daily_plan.save
      redirect_to(
        cohort_daily_plan_path(@cohort, @daily_plan),
        notice: 'Daily Plan successfully created'
      )
    else
      render :new
    end
  end

  def show
    @daily_plan = DailyPlan.where(cohort_id: @cohort).find_by!(date: params[:id])
  end

  def today
    redirect_to cohort_daily_plan_path(@cohort, Date.today.to_s)
  end

  def edit
    @daily_plan = DailyPlan.where(cohort_id: @cohort).find_by!(date: params[:id])
  end

  def update
    @daily_plan = DailyPlan.where(cohort_id: @cohort).find_by!(date: params[:id])

    if @daily_plan.update(daily_plan_params)
      redirect_to(
        cohort_daily_plan_path(@cohort, @daily_plan),
        notice: 'Daily Plan successfully updated'
      )
    else
      render :edit
    end
  end

  def destroy
    @daily_plan = DailyPlan.where(cohort_id: @cohort).find_by!(date: params[:id])
    @daily_plan.try(:destroy)
    redirect_to(
      cohort_daily_plans_path(@cohort),
      notice: 'Daily Plan successfully deleted'
    )
  end

  private

  def daily_plan_params
    params.require(:daily_plan).permit(
      :date,
      :description
    )
  end
end
