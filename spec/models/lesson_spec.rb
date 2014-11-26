require 'rails_helper'

describe "Lesson" do

  it "allows an instructor to assign multiple lesson plans to a cohort" do

    lesson_plan_1 = LessonPlan.create!(name: "Lesson Plan 1")
    lesson_plan_2 = LessonPlan.create!(name: "Lesson Plan 2")
    cohort = create_cohort

    lesson = Lesson.create!(lesson_plan_id: lesson_plan_1.id, cohort_id: cohort.id, date: "01/01/1999" )
    lesson_2 = Lesson.create!(lesson_plan_id: lesson_plan_2.id, cohort_id: cohort.id, date: "01/01/1999" )
    expect(lesson_2).to be_valid


  end

end
