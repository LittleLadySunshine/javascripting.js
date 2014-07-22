require "rails_helper"

feature "Cohorts" do
  let!(:instructor) { create_user(:first_name => "Instructor", :last_name => "User", :github_id => '987', :role_bit_mask => 1) }

  scenario "an instructor creating and editing a cohort" do
    sign_in(instructor)
    
    click_on("Cohorts")
    click_on("New Cohort")

    fill_in("Name", :with => "Some new cohort")
    fill_in("Start date", :with => "2012-01-01")
    fill_in("End date", :with => "2012-02-01")
    fill_in("Google maps location", :with => "http://google.com")
    fill_in("Directions", :with => "These are some directions")

    click_on("Save")

    expect(page).to have_content("Cohort created")
  end
end
