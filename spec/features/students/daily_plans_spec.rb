require "rails_helper"

feature "Daily Plans" do
  let!(:cohort) { create_cohort }
  let!(:student) {
    create_user(
      first_name: "Student",
      last_name: "User",
      cohort: cohort,
      github_id: "abc123"
    )
  }

  scenario "students see action plans" do
    DailyPlan.create!(
      date: Date.today,
      cohort: cohort,
      description: "# Some header"
    )

    sign_in(student)
    click_on("Today's Plan")

    expect(page).to have_content("Some header")
  end

end
