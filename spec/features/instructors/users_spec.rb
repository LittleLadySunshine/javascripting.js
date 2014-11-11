require "rails_helper"

feature "Users" do
  let!(:cohort) { create_cohort }
  let!(:instructor) {
    create_instructor(
      :first_name => "Instructor",
      :last_name => "User",
      :github_id => '987'
    )
  }

  scenario "instructors manage users" do
    sign_in(instructor)

    click_on("Users")
    click_on("New User")

    fill_in("First name", :with => "Joe")
    fill_in("Last name", :with => "Example")
    fill_in("Email", :with => "joe@example.com")
    select("student", :from => "Role")
    select("active", :from => "Status")
    select(cohort.name, :from => "Cohort")

    click_on "Create User"

    expect(page).to have_content("Joe Example")
  end

  scenario "instructors can add employer to a student" do
    user = create_user({cohort: cohort, role: :student})
    instructor.update(cohort_id: cohort.id)

    sign_in(instructor)

    visit "/instructor/cohorts/#{cohort.id}"

    expect(page).to have_link(user.full_name)

    click_link(user.full_name)

    expect(page).to have_content(user.full_name)
    expect(page).to have_link("Edit")

    click_on("Edit")

    fill_in("Employer", :with => "Awesomeness.io")
    click_on("Update Student")

    expect(page).to have_content("Employer")
    expect(page).to have_content("Awesomeness.io")
  end

end
