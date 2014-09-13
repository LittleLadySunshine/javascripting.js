require "rails_helper"

describe "Showcases" do
  def cohort_with_students
    cohort = create_cohort(:name => "Awesome Cohort", :showcase => true)

    create_user(:cohort => cohort,
                :first_name => "Jane",
                :last_name => "Doe",
                :github_username => "janes_github_username",
                :linkedin => "https://linkedin.com/jane")

    create_user(:cohort => cohort,
                :first_name => "John",
                :last_name => "Smith")

    create_user(:cohort => cohort,
                :first_name => "Jeff",
                :last_name => "Taggart",
                :role_bit_mask => 1)

    visit root_path
    click_on "Awesome Cohort"
  end

  it "shows the cohorts that are showcaseable" do
    create_cohort(:name => "Awesome Cohort", :showcase => true)
    create_cohort(:name => "Another Cohort", :showcase => true)
    create_cohort(:name => "Don't show", :showcase => false)

    visit root_path

    expect(page).to have_content("Awesome Cohort")
    expect(page).to have_content("Another Cohort")
    expect(page).to have_no_content("Don't show")
  end

  it "shows the students from the cohort" do
    cohort_with_students

    expect(page).to have_content("Awesome Cohort")
    expect(page).to have_content("Jane Doe")
    expect(page).to have_content("John Smith")
  end

  it "allows someone to view a students" do
    cohort_with_students

    click_on "Jane Doe"

    expect(page).to have_content("Jane Doe")
    expect(page).to have_link("https://github.com/janes_github_username")
    expect(page).to have_link("https://linkedin.com/jane")
  end

end
