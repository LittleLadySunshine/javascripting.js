require "rails_helper"

feature "Feedback" do
  scenario "allows logged in user to give feedback to another student" do
    pending("not used")
    cohort = create_cohort(name: "March gSchool")
    create_user(first_name: "Giving Feedback",
                cohort_id: cohort.id,
                github_id: "1234",
                email: "some@email.com")

    recipient = create_user(first_name: "Receiving Feedback",
                            last_name: "Student",
                            cohort_id: cohort.id, github_id: "9876",
                            email: "another@email.com")

    mock_omniauth(base_overrides: {uid: "1234"},
                  info_overrides: {email: "some@email.com"})

    visit root_path

    click_on I18n.t('nav.sign_in')
    click_on "Cohort"
    click_on I18n.t('nav.feedback')
    click_on I18n.t('feedback.give')

    select "Receiving Feedback Student", from: "feedback_entry[recipient_id]"
    fill_in "feedback_entry[comment]", with: "This person did a great job of explaining Minitest::Spec."

    click_on I18n.t('submit')

    within "#flash" do
      expect(page).to have_content I18n.t('feedback.success')
    end

    within "#feedback-given" do
      expect(page).to have_content(recipient.full_name)
    end

    click_on I18n.t('nav.sign_out')

    # log is as feedback recipient
    mock_omniauth(base_overrides: {uid: "9876"},
                  info_overrides: {email: "another@email.com"})

    visit root_path

    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.feedback')

    within("table tr", text: "Giving Feedback") do
      find('a').click
    end

    expect(page).to have_content "This person did a great job of explaining Minitest::Spec."
  end

  scenario "allows logged in instructor to view students' feedback" do
    cohort = create_cohort(name: "March gSchool")

    instructor = new_user(first_name: "Instructor", github_id: "1234")
    instructor.add_role(User::INSTRUCTOR)
    instructor.save!

    recipient = create_user(first_name: "Receiving",
                            last_name: "Student",
                            cohort_id: cohort.id,
                            github_id: "9876")

    create_feedback_entry(recipient: recipient, provider: create_user, comment: "Great work.")

    mock_omniauth(base_overrides: {uid: "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on "Cohorts"
    click_on "March gSchool"
    click_on I18n.t('nav.feedback')

    select "Receiving Student", from: "feedback_for_student"
    click_on I18n.t('get_feedback')

    within("tr", text: "Receiving") do
      find('a').click
    end

    expect(page).to have_content "Great work."
  end
end
