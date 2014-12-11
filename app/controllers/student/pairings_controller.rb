class Student::PairingsController < SignInRequiredController

  before_action do
    @cohort = Cohort.find(params[:cohort_id])
  end

  def index
    pairings = Pairing.for_user(current_user)
    @pending_users = pairings[:pending].index_by(&:id)
    @done_users = pairings[:done].index_by(&:id)
    main_users = (@cohort.users - [current_user] - @pending_users.values)
    @students = main_users.sort_by{|user| user.full_name }.in_groups_of(6, false)
  end

  def new
    @pairing = Pairing.new
    @pair = @cohort.users.find(params[:student_id])
  end

  def create
    @pairing = Pairing.new(params.require(:pairing).permit(:paired_on, :feedback))
    @pair = @cohort.users.find(params[:student_id])
    @pairing.pair = @pair
    @pairing.user = current_user
    if @pairing.save
      redirect_to cohort_pairings_path(@cohort), notice: "Pairing was created successfully!"
    else
      render :new
    end
  end

end
