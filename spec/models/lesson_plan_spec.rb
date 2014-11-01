require 'rails_helper'

describe LessonPlan do

  it "calculates the percent complete correctly" do
    lesson_plan = LessonPlan.new
    expect(lesson_plan.completed_sections).to eq(0)

    lesson_plan.objectives = "foo"
    expect(lesson_plan.completed_sections).to eq(1)

    lesson_plan.assessment = "foo"
    expect(lesson_plan.completed_sections).to eq(2)
  end

end
