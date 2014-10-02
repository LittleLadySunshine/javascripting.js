require "rails_helper"

feature "Login" do
  scenario "allows a student to log in with github and log out" do
    create_user(first_name: "Github", last_name: "User", email: "user@example.com", cohort_id: create_cohort.id)

    mock_omniauth

    visit root_path
    click_on I18n.t("nav.sign_in")
    within ".alert" do
      expect(page).to have_content(I18n.t("welcome_message", first_name: "Github", last_name: "User"))
    end

    expect(page).to have_content("Students")

    click_on I18n.t("nav.sign_out")

    expect(page).to have_link(I18n.t("nav.sign_in"))
  end

  scenario "allows an instructor to log in with github and log out" do
    create_user(first_name: "Instructor", last_name: "User", email: "user@example.com", role: :instructor, cohort: create_cohort(name: "Denver 2014"))

    mock_omniauth

    visit root_path
    click_on I18n.t("nav.sign_in")

    expect(page).to have_content(I18n.t("welcome_message", first_name: "Instructor", last_name: "User"))

    expect(page).to have_content("Denver 2014 Dashboard")

    click_on I18n.t("nav.sign_out")

    expect(page).to have_link(I18n.t("nav.sign_in"))
  end


  scenario "displays a unauthorized message if the user does not have a record in the db" do
    mock_omniauth

    visit root_path
    click_on I18n.t("nav.sign_in")

    within "#flash" do
      expect(page).to have_content(I18n.t("access_denied"))
    end
  end

  scenario "redirects to the root path when oauth fails" do
    OmniAuth.config.mock_auth[:github] = :invalid_credentials

    visit root_path
    click_on I18n.t("nav.sign_in")

    within "#flash" do
      expect(page).to have_content(I18n.t("login_failed"))
    end
  end
end
