class Instructor::PairsController < InstructorRequiredController

  layout 'application_bootstrap'

  def index
    @cohort = Cohort.find(params[:cohort_id])
    @students = @cohort.students

    @pair_generator = PairGenerator.new(@students)
    @pairs = @pair_generator.random_pairs
  end

end
