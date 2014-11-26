require 'rails_helper'

feature 'Lessons' do

  let!(:cohort) { create_cohort(:name => 'Cohort 1') }
  let!(:instructor) {
    create_instructor(
    :first_name => "Instructor",
    :last_name => "User",
    :github_id => '987',
    )
  }

  scenario 'instructor is able to assign a lesson to a cohort' do

    lesson_plan = LessonPlan.create!(
    name: "Lesson Plan Example"
    )

    sign_in(instructor)
    visit instructor_lesson_plan_path(lesson_plan)
    find("#lesson_cohort_id").select('Cohort 1')
    fill_in 'lesson_date', with: "01/01/1999"
    click_on 'Assign to Cohort'
    expect(page).to have_content('Cohort 1')

  end

  scenario 'instructor is not able to assign a lesson more than once to a cohort' do
    lesson_plan = LessonPlan.create!(
    name: "Lesson Plan Example"
    )

    sign_in(instructor)
    visit instructor_lesson_plan_path(lesson_plan)
    find("#lesson_cohort_id").select('Cohort 1')
    fill_in 'lesson_date', with: "01/01/1999"
    click_on 'Assign to Cohort'
    expect(page).to have_content('Cohort 1')

    find("#lesson_cohort_id").select('Cohort 1')
    fill_in 'lesson_date', with: "01/01/1999"
    click_on 'Assign to Cohort'
    expect(page).to have_content('Cohort has already been taken')

  end


end
