require 'rails_helper'

describe OneOnOneScheduler do
  describe '#generate_schedule' do

    it 'populates the appointments' do
      student = [User.new(first_name: "Student")]
      instructor = [User.new(first_name: "Instructor")]
      scheduler = OneOnOneScheduler.new(student, [instructor])
      scheduler.generate_schedule
      expect(scheduler.appointments.length).to eq(1)
    end

    it 'starts at the designated time' do
      student = [User.new(first_name: "Student"), User.new(first_name: "Student")]
      instructor = [User.new(first_name: "Instructor")]
      scheduler = OneOnOneScheduler.new(student, [instructor], '10:15am')
      scheduler.generate_schedule
      appointments = scheduler.appointments
      expect(appointments.first.time).to eq('10:15am')
      expect(appointments.second.time).to eq('10:30am')
    end

  end
end
