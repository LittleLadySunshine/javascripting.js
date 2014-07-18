require "rails_helper"

feature "Attendance" do

  let!(:boulder_cohort) { create_cohort(name: "Boulder gSchool") }
  let!(:denver_cohort) { create_cohort(name: "Denver gSchool") }
  let!(:instructor) { create_user(first_name: "Instructor", last_name: "User", github_id: "987", role_bit_mask: 1, cohort_id: boulder_cohort.id) }
  let!(:student) { create_user(first_name: "Student", last_name: "User", github_id: "123", cohort_id: boulder_cohort.id, github_username: "Student12345") }
  let!(:other_student) { create_user(first_name: "Other", last_name: "Student", github_id: "321", cohort_id: boulder_cohort.id, github_username: "Student54321") }
  let!(:other_cohort_student) { create_user(first_name: "Other", last_name: "Cohort", github_id: "789", cohort_id: denver_cohort.id, github_username: "Student23456") }

  before do
    Timecop.freeze(Date.new(2014, 7, 11))
    sign_in(instructor)
  end

  after do
    Timecop.return
  end

  scenario "As an instructor, the first date is today if not entered already" do
    click_on "Attendance"

    expect(page).to have_content "#{Date.new(2014, 7, 11)}"

    check "Student User"
    uncheck "Other Student"

    click_on "Submit Attendance"

    expect(page).to have_content "Attendance successfully submitted"
  end


  scenario "As an instructor, I can only enter attendance for students from my cohort" do
    click_on "Attendance"

    expect(page).to have_content "#{boulder_cohort.name}"
    expect(page).to have_content "Student User"
    expect(page).to have_content "Other Student"
    expect(page).not_to have_content "Other Cohort"
  end

  scenario "As an instructor, I should not be able to enter today's attendance twice" do
    click_on "Attendance"
    expect(page).to have_content "#{Date.new(2014, 7, 11)}"
    click_on "Submit Attendance" # submits today's date
    expect(page).to have_content "Attendance successfully submitted"

    click_on "Attendance"

    expect(page).not_to have_content "#{Date.new(2014, 7, 11)}"

    click_on "Submit Attendance"

    expect(page).to have_content "Attendance successfully submitted"
  end

  scenario "As an instructor, I can take select attendance for a previous date" do
    click_on "Attendance"

    select "#{Date.new(2014, 7, 11).yesterday.to_s}"

    click_on "Submit Attendance"

    expect(page).to have_content "Attendance successfully submitted"
  end

  scenario "As an instructor, I should not be able to enter attendance on Saturday" do
    Timecop.freeze(Date.new(2014, 7, 12))
    click_on "Attendance"

    expect(page).not_to have_content "#{Date.new(2014, 7, 12)}"
    Timecop.return
  end

  scenario "As an instructor, I should not be able to enter attendance on Sunday" do
    Timecop.freeze(Date.new(2014, 7, 13))
    click_on "Attendance"

    expect(page).not_to have_content "#{Date.new(2014, 7, 13)}"
    Timecop.return
  end

  scenario "As an instructor, I should not be able to enter attendance on a Holiday" do
    Timecop.freeze(Date.new(2014, 7, 4))
    click_on "Attendance"

    expect(page).not_to have_content "#{Date.new(2014, 7, 4)}"
    Timecop.return
  end


end
