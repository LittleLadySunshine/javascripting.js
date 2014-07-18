require "rails_helper"

feature "Student adding a personal project" do
  scenario "adding and editing the personal project" do
    @cohort = create_cohort(name: "Cohort Name",
                            google_maps_location: "this is a google map url",
                            directions: '<p>The classroom is on the right</p><p>This is some more text</p>')
    create_user(first_name: "Jeff", last_name: "Taggart", email: "user@example.com", cohort: @cohort)
    mock_omniauth

    visit root_path
    click_on I18n.t("nav.sign_in")
    click_on "Personal Project"

    fill_in "Name", :with => "New Awesome App"
    fill_in "Description", :with => "This is a description of my application. This needs a lot of words to be valid"
    fill_in "GitHub Repo name", :with => "new-awesome-app"
    fill_in "Tracker Project", :with => "http://pivotaltracker.com/something"
    fill_in "Production URL (i.e. Heroku)", :with => "http://awesomepossum.com"
    click_on "Save"

    expect(page).to have_content("Personal Project Saved")
    expect(page).to have_content("New Awesome App")
    expect(page).to have_content("This is a description of my application. This needs a lot of words to be valid")
    expect(page).to have_link("GitHub")
    expect(page).to have_link("Tracker")
    expect(page).to have_link("Production")

    click_on "Personal Project"

    expect(page).to have_content("New Awesome App")

    click_on "Edit"

    fill_in "Name", :with => "An even better name"

    click_on "Save"

    expect(page).to have_content("Personal Project Saved")
    expect(page).to have_content("An even better name")
  end
end
