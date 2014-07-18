require 'rails_helper'

feature "Cohorts" do

  let!(:cohort) { create_cohort(:name => 'Boulder gSchool') }
  let!(:instructor) { create_user(:first_name => "Instructor", :last_name => "User", :github_id => '987', :role_bit_mask => 1) }
  let!(:student) { create_user(:first_name => "Student", :last_name => "User", :github_id => '123', :cohort_id => cohort.id, :github_username => "Student12345") }

  scenario "instructor can add student to cohort" do
    sign_in(instructor)

    visit '/instructor/dashboard'

    find('.card', :text => 'Boulder gSchool').click
    click_on 'Add Student'

    fill_in 'First name', :with => 'John'
    fill_in 'Last name', :with => 'Johnson'
    fill_in 'Email', :with => 'john@johnny.com'

    click_on 'Add Student'

    expect(page).to have_content('Student added successfully')
    expect(page).to have_content('Boulder gSchool')
    expect(page).to have_content('John Johnson')
    expect(page).to have_content('john@johnny.com')
  end

  scenario "it shows errors on the add student form" do
    sign_in(instructor)

    visit '/instructor/dashboard'

    click_on 'Boulder gSchool'
    click_on 'Add Student'

    click_on 'Add Student'

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
  end

  scenario "instructors can see a one-on-one schedule" do
    instructor = create_user(:first_name => "Teacher", :last_name => "User", :github_id => '1010', :role_bit_mask => 1)
    create_user(:first_name => "Student", :last_name => "User", :github_id => '1111', :cohort_id => cohort.id, :github_username => "Student12345")

    sign_in(instructor)

    visit '/instructor/dashboard'
    click_on cohort.name
    click_on '1-on-1 Schedule'

    expect(page).to have_content("Student User")
    expect(page).to have_content("Teacher User")
    expect(page).to have_content("1pm")
  end

end
