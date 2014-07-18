class OneOnOneScheduler

  attr_reader :students, :instructors, :appointments, :unscheduled_students

  def initialize(students, instructors)
    @students = students
    @instructors = instructors
  end

  def generate_schedule
    current_students = students.to_a.dup
    times = %w(1pm 1:15pm 1:30pm 1:45pm 2pm 2:15pm 2:30pm 3pm 3:15pm 3:30pm 3:45pm 4pm 4:15pm 4:30pm 4:45pm)

    @appointments = []
    times.each do |time|
      instructors.each do |instructor|
        student = current_students.sample
        if student
          current_students.delete(student)
          @appointments << OpenStruct.new(:instructor => instructor, :student => student, :time => time)
        else
          break
        end
      end
    end

    @unscheduled_students = current_students
  end

end