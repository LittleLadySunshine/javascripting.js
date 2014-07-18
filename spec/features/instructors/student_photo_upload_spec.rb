require "rails_helper"

feature "Instructor adding student photos" do
  before do
    @cohort = create_cohort(:name => "Cohort Name",
                            :google_maps_location => "this is a google map url",
                            :directions => '<p>The classroom is on the right</p><p>This is some more text</p>')
    create_user(
      :first_name => "Jeff",
      :last_name => "Taggart",
      :email => "user@example.com",
      :cohort => @cohort,
      :role_bit_mask => User::INSTRUCTOR)

    create_user(
      :first_name => "John",
      :last_name => "Foley",
      :email => "foley@example.com",
      :cohort => @cohort)
    mock_omniauth

    visit root_path
    click_on I18n.t("nav.sign_in")
  end

  scenario "Instructors can upload student photos" do
    click_on "John Foley"
    click_on "Edit"
    attach_file "Avatar", Rails.root.join("spec", "fixtures", "avatar.jpg")
    click_on "Update Student"
    click_on "John Foley"

    expect(page).to have_selector("img[src$='avatar.jpg']")
  end
end
