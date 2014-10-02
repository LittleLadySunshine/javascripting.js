require "rails_helper"

feature "Instructor cohorts" do

  let!(:cohort) { create_cohort(:name => 'Boulder gSchool') }
  let!(:instructor) { create_user(:first_name => "Instructor", :last_name => "User", :github_id => '987', :role => :instructor, :cohort_id => cohort.id) }
  let!(:student) { create_user(:first_name => "Student", :last_name => "User", :github_id => '123', :cohort_id => cohort.id, :github_username => "Student12345") }

  scenario "instructor is able to view the cohorts" do
    sign_in(instructor)

    visit '/instructor/cohorts'

    expect(page).to have_content(cohort.name)
  end

  scenario "non-instructors cannot see the instructor cohorts" do
    visit '/instructor/cohorts'
    expect(page).to have_content("Please sign in to access that page")
    expect(page.current_path).to_not eq('/instructor/cohorts')

    sign_in(student)

    visit '/instructor/cohorts'
    expect(page.current_path).to_not eq('/instructor/cohorts')
  end

  scenario "instructor can see a list of students (not instructors) and a link to their github repository" do
    create_user(:first_name => "Student", :last_name => "Without github", :cohort_id => cohort.id)

    sign_in(instructor)

    visit '/instructor/cohorts'

    click_on 'Boulder gSchool'

    within "tr", :text => "Student User" do
      expect(page).to have_link("GitHub")
    end

    within "tr", :text => "Student Without github" do
      expect(page).to have_no_link("GitHub")
    end

    within ".table" do
      expect(page).to have_no_content("Instructor User")
    end
  end

end
