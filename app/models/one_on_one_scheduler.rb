class OneOnOneScheduler

  attr_reader :students, :instructors, :appointments, :unscheduled_students

  def initialize(students, instructors, start_time = '1:00pm')
    @students = students
    @instructors = instructors
    @start_time = start_time
  end

  def generate_schedule
    current_students = students.to_a.dup
    index = self.class.all_times.index(@start_time)
    times = self.class.all_times[index..-1]

    @appointments = []
    times.each do |time|
      instructors.each do |instructor|
        student = current_students.sample
        if student
          current_students.delete(student)
          @appointments << OpenStruct.new(
            instructor: instructor,
            student: student,
            time: time
          )
        else
          break
        end
      end
    end

    @unscheduled_students = current_students
  end

  def self.all_times
    %w(
      9:00am
      9:15am
      9:30am
      9:45am
      10:00am
      10:15am
      10:30am
      10:45am
      11:00am
      11:15am
      11:30am
      11:45am
      12:00am
      12:15am
      12:30am
      12:45am
      1:00pm
      1:15pm
      1:30pm
      1:45pm
      2:00pm
      2:15pm
      2:30pm
      2:45pm
      3:00pm
      3:15pm
      3:30pm
      3:45pm
      4:00pm
      4:15pm
      4:30pm
      4:45pm
      5:00pm
      5:15pm
      5:30pm
      5:45pm
      6:00pm
      6:15pm
      6:30pm
      6:45pm
      7:00pm
    )
  end

end
