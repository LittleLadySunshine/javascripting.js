require "rails_helper"

feature "Cohorts" do
  let!(:instructor) { create_instructor(:first_name => "Instructor", :last_name => "User", :github_id => '987') }

  scenario "an instructor creating and editing a cohort" do
    sign_in(instructor)

    click_on("Cohorts")
    click_on("New Cohort")

    fill_in("Name", :with => "Some new cohort")
    fill_in("Start date", :with => "2012-01-01")
    fill_in("End date", :with => "2012-02-01")
    fill_in("Google maps location", :with => "http://google.com")
    fill_in("Directions", :with => "These are some directions")
    fill_in("Pair feedback url", :with => "http://google.com/pair_feedback")
    attach_file "Hero", Rails.root.join("spec", "fixtures", "avatar.jpg")

    check "Showcase"

    click_on("Save")

    expect(page).to have_content("Cohort created")

    click_on "Some new cohort"
    click_on "Edit"

    expect(find_field("Name").value).to eq("Some new cohort")
    expect(find_field("Start date").value).to eq("2012-01-01")
    expect(find_field("End date").value).to eq("2012-02-01")
    expect(find_field("Google maps location").value).to eq("http://google.com")
    expect(find_field("Directions").value).to eq("These are some directions")
    expect(find_field("Pair feedback url").value).to eq("http://google.com/pair_feedback")
    expect(page).to have_checked_field("Showcase")

    fill_in("Name", :with => "Another new name")

    click_on("Save")

    expect(page).to have_content("Cohort saved")
    expect(page).to have_content("Another new name")
  end

  context "with an already existing cohort" do
    let!(:cohort) { create_cohort(:name => 'Boulder gSchool') }
    let!(:student) { create_user(:first_name => "Student", :last_name => "User", :github_id => '123', :cohort_id => cohort.id, :github_username => "Student12345") }

    scenario "instructor can add student to cohort" do
      sign_in(instructor)

      visit '/instructor/cohorts'

      click_on 'Boulder gSchool'
      click_on 'Add Student'

      fill_in 'First name', :with => 'John'
      fill_in 'Last name', :with => 'Johnson'
      fill_in 'Email', :with => 'john@johnny.com'
      click_on 'Create User'

      expect(page).to have_content('User created successfully')
      expect(page).to have_content('Boulder gSchool')
      expect(page).to have_content('John Johnson')
      expect(page).to have_content('john@johnny.com')
    end

    scenario "it shows errors on the add student form" do
      sign_in(instructor)

      visit '/instructor/cohorts'

      click_on 'Boulder gSchool'
      click_on 'Add Student'
      click_on 'Create User'

      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
    end

    scenario "instructors can see a one-on-one schedule" do
      instructor = create_instructor(:first_name => "Teacher", :last_name => "User", :github_id => '1010')
      create_user(:first_name => "Student", :last_name => "User", :github_id => '1111', :cohort_id => cohort.id, :github_username => "Student12345")
      create_staffing(cohort: cohort, user: instructor)
      sign_in(instructor)

      visit '/instructor/cohorts'
      click_on cohort.name
      click_on '1-on-1 Schedule'

      expect(page).to have_content("Student User")
      expect(page).to have_content("Teacher User")
      expect(page).to have_content("1:00pm")
    end

    scenario "instructors can see a table of acceptance links for gCamp" do
      instructor = create_instructor(:first_name => "Teacher", :last_name => "User", :github_id => '1010')
      user = create_user(:first_name => "Student", :last_name => "User", :github_id => '1111', :cohort_id => cohort.id, :github_username => "Student12345")
      create_staffing(cohort: cohort, user: instructor)
      ClassProject.create!(name: 'gCamp')
      sign_in(instructor)

      StudentProject.create!(
        user: user,
        name: 'gCamp',
      )

      visit '/instructor/cohorts'
      click_on cohort.name
      click_on 'gCamp Acceptance'

      expect(page).to have_content("Student User")
    end

  end
end
