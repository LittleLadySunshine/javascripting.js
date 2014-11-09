require "rails_helper"

feature "Assessments" do
  let(:cohort) { create_cohort }

  let!(:instructor) {
    create_instructor(
      first_name: "Instructor",
      last_name: "User",
      github_id: '987',
    )
  }

  let!(:student1) {
    create_user(
      first_name: "Joe",
      last_name: "Example",
      cohort: cohort,
    )
  }

  let!(:student2) {
    create_user(
      first_name: "Betty",
      last_name: "Example",
      cohort: cohort,
    )
  }

  let!(:rubric) {
    Rubric.create!(
      name: "Growth Mindset",
      questions_json: [
        {
          title: "Displayed growth mindset behavior",
          question_type: "scale",
          options: {
            scale_start: 1,
            scale_end: 4,
            first_label: "Nope, never",
            last_label: "Yup, always",
          }
        },
        {
          title: "Did not display fixed mindset behavior",
          question_type: "scale",
          options: {
            scale_start: 1,
            scale_end: 4,
            first_label: "Nope, never",
            last_label: "Yup, always",
          }
        }
      ]
    )
  }

  scenario "instructor assesses a student based on a rubric" do
    sign_in(instructor)
    click_on(cohort.name)
    click_on("Assessments")
    click_on("Growth Mindset")
    click_on("Assess #{student1.full_name}")
    choose "question-0-4"
    choose "question-1-1"
    click_on("Create Assessment")

    expect(page).to have_content(student1.full_name)
    expect(page).to have_content(student2.full_name)
  end
end
