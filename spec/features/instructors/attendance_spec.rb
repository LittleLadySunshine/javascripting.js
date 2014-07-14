require "spec_helper"

feature "Attendance" do

  let!(:boulder_cohort) { create_cohort(name: "Boulder gSchool") }
  let!(:denver_cohort) { create_cohort(name: "Denver gSchool") }
  let!(:instructor) { create_user(first_name: "Instructor", last_name: "User", github_id: "987", role_bit_mask: 1, cohort_id: boulder_cohort.id) }
  let!(:student) { create_user(first_name: "Student", last_name: "User", github_id: "123", cohort_id: boulder_cohort.id, github_username: "Student12345") }
  let!(:other_student) { create_user(first_name: "Other", last_name: "Student", github_id: "321", cohort_id: boulder_cohort.id, github_username: "Student54321") }
  let!(:other_cohort_student) { create_user(first_name: "Other", last_name: "Cohort", github_id: "789", cohort_id: denver_cohort.id, github_username: "Student23456") }

  before do
    @today = Date.new(2014, 7, 11) # set @today to known Friday
    sign_in(instructor)
  end

  scenario "As an instructor, the first date is today if not entered already" do
    click_on "Attendance"

    expect(page).to have_content "#{@today.to_s}"

    check "Student User"
    uncheck "Other Student"

    click_on "Submit Attendance"

    expect(page).to have_content "Attendance successfully submitted"
  end

  scenario "As an instructor, I can enter attendance for my students" do
    click_on "Attendance"

    expect(page).to have_content "Student User"
    expect(page).to have_content "Other Student"
  end

  scenario "As an instructor, I should not be able to enter attendance on students from other cohorts" do
    click_on "Attendance"

    expect(page).not_to have_content "Other Cohort"
  end

  scenario "As an instructor, I expect to see my cohort name" do
    click_on "Attendance"

    expect(page).to have_content "#{boulder_cohort.name}"
  end

  scenario "As an instructor, I should not be able to enter today's attendance twice" do
    skip
    click_on "Attendance"
    expect(page).to have_content "#{@today.to_s}"
    click_on "Submit Attendance" # submits @today
    expect(page).to have_content "Attendance successfully submitted"

    click_on "Attendance"

    expect(page).not_to have_content "#{@today.to_s}"

    click_on "Submit Attendance"

    expect(page).to have_content "Attendance successfully submitted"

  end

  scenario "As an instructor, I can take select attendance for a previous date" do
    click_on "Attendance"

    select "#{@today.yesterday.to_s}"

    click_on "Submit Attendance"

    expect(page).to have_content "Attendance successfully submitted"

  end

  scenario "As an instructor, I should not be able to enter attendance on Saturday" do
    @today = Date.new(2014,7,12) # set @today to a known Saturday
    click_on "Attendance"

    expect(page).not_to have_content "#{@today}"

  end

  scenario "As an instructor, I should not be able to enter attendance on Sunday" do
    @today = Date.new(2014,7,13) # set @today to a known Sunday
    click_on "Attendance"

    expect(page).not_to have_content "#{@today}"

  end

  scenario "As an instructor, I should not be able to enter attendance on a Holiday" do
    @today = Date.new(2014,7,4) # set @today to known holiday
    click_on "Attendance"

    expect(page).not_to have_content "#{@today}"

  end


end
