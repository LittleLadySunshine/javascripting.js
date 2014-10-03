require "rails_helper"

feature "Student adding a personal project" do
  scenario "adding and editing the personal project" do
    cohort = create_cohort(:name => "Cohort Name")
    student = create_user(:cohort => cohort,
                          :first_name => "Bob",
                          :last_name => "Builder")
    create_personal_project(:name => "Some personal project",
                            :description => "This is a long description",
                            :user => student)

    create_instructor(
      :first_name => "Jeff",
      :last_name => "Taggart",
      :email => "user@example.com"
    )

    mock_omniauth
    visit root_path
    click_on "Sign In"

    visit "/instructor/cohorts"
    click_link cohort.name

    click_on "Bob Builder"

    expect(page).to have_content("Some personal project")
    expect(page).to have_content("This is a long description")
    expect(page).to have_link("GitHub")
    expect(page).to have_link("Tracker")
    expect(page).to have_link("Production")

  end
end
