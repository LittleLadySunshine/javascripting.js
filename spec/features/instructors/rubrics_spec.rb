require "rails_helper"

feature "Rubrics" do
  let!(:instructor) {
    create_instructor(
      first_name: "Instructor",
      last_name: "User",
      github_id: '987',
    )
  }

  scenario "an instructor can define an assessment" do
    sign_in(instructor)
    click_on("Rubrics")
    click_on("New Rubric")
    fill_in "Name", with: "Growth Mindset Rubric"
    fill_in "Questions", with: [
      {
        title: "Uses growth mindset language",
        question_type: "scale",
        options: {
          scale_start: 1,
          scale_end: 4,
          first_label: "Never",
          last_label: "Always"
        }
      }
    ].to_json
    click_on("Create Rubric")

    expect(page).to have_content("Uses growth mindset language")
    expect(page).to have_content("Scale (1: Never, 4: Always)")
  end
end
