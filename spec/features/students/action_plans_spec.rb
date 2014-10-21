require "rails_helper"

feature "Action Plans" do
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
    ActionPlanEntry.create!(
      user: student,
      cohort: cohort,
      description: "# Some header"
    )

    sign_in(student)
    click_on("Action Plan")

    expect(page).to have_css(".panel h1", text: "Some header")
  end

end
