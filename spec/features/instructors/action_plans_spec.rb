require "rails_helper"

feature "Action Plans" do
  let!(:cohort) { create_cohort }
  let!(:instructor) {
    create_instructor(
      :first_name => "Instructor",
      :last_name => "User",
      :github_id => '987',
    )
  }
  let!(:student) {
    create_user(
      first_name: "Student",
      last_name: "User",
      cohort: cohort
    )
  }

  scenario "instructors can create action plans for students" do
    ActionMailer::Base.deliveries = []
    sign_in(instructor)

    click_on("Cohorts")
    click_on(cohort.name)
    click_on("Action Plans")
    click_on("Student User")
    click_on("New Entry")

    fill_in "Description", with: "# Some header"
    click_on "Create Action plan entry"

    expect(page).to have_css(".panel h1", text: "Some header")

    within('.panel'){ click_on("Edit") }

    fill_in "Description", with: "* some list"
    click_on "Update Action plan entry"

    expect(page).to have_css(".panel li", text: "some list")

    within('.panel'){ click_on("Delete") }

    expect(page).to have_no_css(".panel li", text: "some list")
  end

end
