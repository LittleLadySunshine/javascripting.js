require "spec_helper"

feature "Attendance" do

  let!(:cohort) { create_cohort(:name => "Boulder gSchool") }
  let!(:instructor) { create_user(:first_name => "Instructor", :last_name => "User", :github_id => "987", :role_bit_mask => 1, :cohort_id => cohort.id) }
  let!(:student) { create_user(:first_name => "Student", :last_name => "User", :github_id => "123", :cohort_id => cohort.id, :github_username => "Student12345") }
  let!(:other_student) { create_user(:first_name => "Other", :last_name => "Student", :github_id => "321", :cohort_id => cohort.id, :github_username => "Student54321") }

  before do
    sign_in(instructor)
  end

  scenario "As an instructor, I can take attendance" do
    click_on "Attendance"

    expect(page).to have_content "Attendance for #{Date.today.to_s}"

    check "Student User"
    uncheck "Other Student"

    click_on "Submit Attendance"

    expect(page).to have_content "Attendance successfully submitted"
  end
end
