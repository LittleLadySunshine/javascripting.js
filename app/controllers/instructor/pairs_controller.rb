class Instructor::PairsController < InstructorRequiredController

  def index
    @cohort = Cohort.find(params[:cohort_id])
    @students = @cohort.users

    @pair_generator = PairGenerator.new(@students)
    @pairs = @pair_generator.random_pairs
  end

end
