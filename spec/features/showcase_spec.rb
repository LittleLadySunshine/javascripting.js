require "rails_helper"

feature "Showcases" do
  it "shows the cohorts" do
    create_cohort(:name => "Awesome Cohort")
    create_cohort(:name => "Another Cohort")

    visit root_path

    expect(page).to have_content("Awesome Cohort")
    expect(page).to have_content("Another Cohort")
  end

  it "shows the students from the cohort" do
    cohort = create_cohort(:name => "Awesome Cohort")
    create_user(:cohort => cohort,
                :first_name => "Jane",
                :last_name => "Doe")

    create_user(:cohort => cohort,
                :first_name => "John",
                :last_name => "Smith")

    create_user(:cohort => cohort,
                :first_name => "Jeff",
                :last_name => "Taggart",
                :role_bit_mask => 1)

    visit root_path

    click_on "Awesome Cohort"

    expect(page).to have_content("Awesome Cohort")
    expect(page).to have_content("Jane Doe")
    expect(page).to have_content("John Smith")
  end
end