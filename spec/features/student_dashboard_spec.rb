require "spec_helper"

feature "A student viewing their dashboard" do
  before do
    @cohort = create_cohort(name: "Cohort Name",
                            google_maps_location: "this is a google map url",
                            directions: '<p>The classroom is on the right</p><p>This is some more text</p>')
    create_user(first_name: "Jeff", last_name: "Taggart", email: "user@example.com", cohort: @cohort)
    mock_omniauth

    visit root_path
    click_on I18n.t("nav.sign_in")
  end

  scenario "shows the student other students in the cohort" do
    create_user(first_name: "Another",
                last_name: "Student",
                phone: "303-111-1111",
                email: "another@user.com",
                cohort: @cohort)

    create_user(first_name: "One",
                last_name: "More",
                email: "one@more.com",
                phone: "303-111-2222",
                twitter: "some_twitter_handle",
                cohort: @cohort)

    create_user(first_name: "Not",
                last_name: "Me",
                email: "not@me.com",

                cohort: create_cohort)

    click_on "Dashboard"

    expect(page).to have_content("Another Student")
    expect(page).to have_content("One More")

    expect(page).to have_no_content("Jeff Taggart")
    expect(page).to have_no_content("Not Me")

    click_on "One More"

    expect(page).to have_no_content("Another Student")
    expect(page).to have_content("One More")
    expect(page).to have_content("some_twitter_handle")
  end

  scenario "getting info about class and preparation" do
    click_on "Info"

    expect(find("#google_map_location")["src"]).to eq("this is a google map url")

    expect(page).to have_content('The classroom is on the right')
    expect(page).to have_content('This is some more text')

    expect(page).to have_no_content('<p>This is some more text</p>')
  end

end
