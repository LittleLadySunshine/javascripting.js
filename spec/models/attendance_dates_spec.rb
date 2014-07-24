require 'rails_helper'
require_relative "../../app/models/attendance_dates"

describe AttendanceDates do

  let!(:boulder_cohort) { create_cohort(name: "Boulder gSchool") }

  before do
    @sheet = AttendanceDates.new(:boulder_cohort)
  end

  after do
    @sheet = nil
  end

  it "has a cohort with factory defaults" do
    expect(boulder_cohort[:name]).to eq("Boulder gSchool")
    expect(boulder_cohort[:start_date].to_s).to eq("2001-01-01")
    expect(boulder_cohort[:end_date].to_s).to eq("2001-01-06")
  end

  it " " do
    expect(@sheet.cohort).to eq(:boulder_cohort)
  end

end
