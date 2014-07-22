require "rails_helper"

feature "Exercises" do

  let!(:cohort) { create_cohort(:name => "Boulder gSchool") }
  let!(:instructor) { create_user(:first_name => "Instructor", :last_name => "User", :github_id => "987", :role_bit_mask => 1) }
  let!(:student) { create_user(:first_name => "Student", :last_name => "User", :github_id => "123", :cohort_id => cohort.id, :github_username => "Student12345") }

  before do
    sign_in(instructor)
  end

  scenario "instructor is able to create and edit exercises" do
    within("#navigation-menu") { click_on "Exercises" }
    click_on "Create Exercise"

    fill_in "Name", :with => "Bunch of array"
    fill_in "GitHub Repo", :with => "http://exercises.com/repo"
    fill_in "Tags", :with => "warmup, easy"
    click_on "Add Exercise"

    expect(page).to have_content "Exercise successfully created"
    expect(page).to have_content("Bunch of array")
    expect(page).to have_content("warmup")
    expect(page).to have_content("easy")

    expect(find_link("Bunch of array")['href']).to eq("http://exercises.com/repo")
    find(".edit-exercise", :visible => false).click

    fill_in "Name", :with => "Bunch of Hashes"
    fill_in "GitHub Repo", :with => "http://exercises.com/hash_repo"
    click_on "Update Exercise"

    expect(page).to have_content "Exercise successfully created"
    expect(find_link("Bunch of Hashes")['href']).to eq("http://exercises.com/hash_repo")
  end

  scenario "instructor can assign and un-assign an exercise to a cohort" do
    create_exercise(:name => "Nested Hashes", github_repo: "http://exercises.com/nested_hashes")

    visit "/instructor/dashboard"

    click_link cohort.name
    within(".sub-nav", :text => cohort.name) do
      click_link "Exercises"
    end
    click_link "Assign Exercise"

    select "Nested Hashes"
    click_button "Add Exercise"

    expect(page).to have_content "Exercise successfully added to cohort"
    expect(find_link("Nested Hashes")['href']).to eq("http://exercises.com/nested_hashes")

    find(".remove-exercise-action", :visible => false).click

    expect(page).to have_content("Exercise removed.")
    expect(page).to have_no_content("Nested Hashes")
  end

  scenario "instructor can view who has and has not completed an exercise" do
    create_user(:first_name => "Joe", :last_name => "Mama", :cohort_id => cohort.id)

    exercise = create_exercise(:name => "Nested Hashes")
    cohort.update!(:exercises => [exercise])
    create_submission(:exercise => exercise,
                      :user => student,
                      :tracker_project_url => "http://www.pivotaltracker.com",
                      :github_repo_name => "some_repo_name")

    visit "/instructor/dashboard"
    click_link cohort.name
    within(".sub-nav", :text => cohort.name) do
      click_link "Exercises"
    end
    submission_count_link = find("td.submission_count a")
    expect(submission_count_link.text).to eq("1")
    submission_count_link.click

    within("section", :text => "Completed Submissions") do
      expect(all("a").first["href"]).to eq("https://github.com/Student12345/some_repo_name")
      expect(page).to have_link("Tracker Project")
    end

    within("section", :text => "Students Without Submissions") do
      expect(page).to have_content("Joe Mama")
    end
  end

  scenario "instructor can view what exercises a student has completed" do
    exercise_1 = create_exercise(:name => "Nested Hashes")
    exercise_2 = create_exercise(:name => "Arrays")

    cohort.update!(:exercises => [exercise_1, exercise_2])

    create_submission(:exercise => exercise_1,
                      :user => student,
                      :github_repo_name => "some_repo_name")


    visit "/instructor/dashboard"
    click_on cohort.name
    click_on "Student User"

    within(".exercises", :text => "Completed Exercises") do
      expect(page).to have_content("Nested Hashes")
    end

    within(".exercises", :text => "Incomplete Exercises") do
      expect(page).to have_content("Arrays")
    end
  end

  scenario "instructor can filter exercises by tag" do
    exercise_1 = create_exercise(:name => "Nested Hashes", :tag_list => ["warmup"])
    exercise_2 = create_exercise(:name => "Arrays", :tag_list => ["warmup", "hard"])
    exercise_3 = create_exercise(:name => "Another easy array", :tag_list => ["warmup", "easy"])
    exercise_4 = create_exercise(:name => "Hard hashes", :tag_list => ["project", "easy"])

    cohort.update!(:exercises => [exercise_1, exercise_2, exercise_3, exercise_4])

    within("#navigation-menu") { click_on "Exercises" }

    fill_in "Filter by", :with => "warmup"
    click_on "Filter"

    expect(page).to have_content("Nested Hashes")
    expect(page).to have_content("Arrays")
    expect(page).to have_content("Another easy array")
    expect(page).to have_no_content("Hard hashes")

    fill_in "Filter", :with => "warmup, easy"
    click_on "Filter"

    expect(page).to have_content("Another easy array")
    expect(page).to have_no_content("Nested Hashes")
    expect(page).to have_no_content("Arrays")
    expect(page).to have_no_content("Hard hashes")

    click_link "Clear Filters"

    expect(page).to have_content("Another easy array")
    expect(page).to have_content("Nested Hashes")
    expect(page).to have_content("Arrays")
    expect(page).to have_content("Hard hashes")
  end
end
