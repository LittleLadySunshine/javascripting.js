require 'rails_helper'

feature 'Job Opportunities' do
  let!(:cohort) { create_cohort(name: 'Boulder gSchool') }
  let!(:instructor) { create_user(first_name: "Instructor", last_name: "User", github_id: '987', role_bit_mask: 1, cohort_id: cohort.id) }

  scenario 'allows student to view the gSchool employment page' do
    cohort = create_cohort(name: "March gSchool")
    create_user(first_name: "Student", cohort_id: cohort.id, github_id: "1234")

    mock_omniauth(base_overrides: {uid: "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')

    expect(page).to have_content "gSchool Employment"
    expect(page).to have_content "Available Jobs to Apply to"
  end

  scenario 'allows student to add a new job opportunity' do
    cohort = create_cohort(name: "March gSchool")
    create_company(name: "Sensei Academy")
    create_user(first_name: "Student", cohort_id: cohort.id, github_id: "1234")

    mock_omniauth(base_overrides: {uid: "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')

    click_on 'Add a New Opportunity'
    select "Sensei Academy", from: :job_opportunity_company_id
    fill_in :job_opportunity_application_due_date, with: '07/30/2014'
    fill_in :job_opportunity_location, with: 'Denver'
    fill_in :job_opportunity_salary, with: '80,000'
    fill_in :job_opportunity_description_link, with: 'http://example.com/job-description'
    select "Direct Application", from: :job_opportunity_application_type
    select "Public", from: :job_opportunity_visibility
    fill_in :job_opportunity_job_title, with: 'Software Engineer'
    click_on 'Create Job Opportunity'

    expect(page).to have_content('Job Opportunity Successfully Created')
    within('.job_opportunities') do
      expect(page).to have_content('Sensei Academy')
    end
  end

  it 'allows students to add a new private job' do
    cohort = create_cohort(name: "gSchool")
    create_company
    student = create_user(cohort_id: cohort.id, github_id: "1234")
    other_student = create_user(cohort_id: cohort.id, github_id: "4321")

    mock_user_login(student)

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')

    click_on 'Add a New Opportunity'
    select "Pivotal Labs", from: :job_opportunity_company_id
    fill_in :job_opportunity_application_due_date, with: '07/30/2014'
    fill_in :job_opportunity_location, with: 'Denver'
    fill_in :job_opportunity_salary, with: '80,000'
    select "Direct Application", from: :job_opportunity_application_type
    select "Private", from: :job_opportunity_visibility
    fill_in :job_opportunity_job_title, with: 'Software Engineer'
    click_on 'Create Job Opportunity'

    expect(page).to have_content('Job Opportunity Successfully Created')
    within(".job_opportunities") do
      expect(page).to have_content('Pivotal Labs')
    end

    click_on "Sign Out"

    mock_user_login(other_student)
    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')

    within(".job_opportunities") do
      expect(page).to_not have_content('Pivotal Labs')
    end
  end

  scenario 'allows student to view their added jobs on their employment dashboard' do
    cohort = create_cohort(name: "March gSchool")
    create_job_opportunity
    create_user(first_name: "Student", cohort_id: cohort.id, github_id: "1234")

    mock_omniauth(base_overrides: {uid: "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')
    find('.add-job', visible: false).click

    within(".jobs_to_apply_for") do
      expect(page).to have_content 'Pivotal Labs'
    end

    visit job_opportunities_path
    find('.add-job', visible: false).click
    expect(page).to have_content 'You already added this job'
  end

  scenario 'allows an instructor to view the admin dashboard for employment' do
    sign_in(instructor)

    visit root_path
    click_on I18n.t('nav.job_opportunity')
    create_job_opportunity
    click_on "Admin Dashboard"

    expect(page).to have_content 'Admin Job Dashboard'
    click_link 'Pivotal Labs'
  end

  scenario 'does not allow a student to view the admin dashboard for employment' do
    cohort = create_cohort(name: "March gSchool")
    create_user(first_name: "Student", cohort_id: cohort.id, github_id: "1234")
    mock_omniauth(base_overrides: {uid: "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')
    click_on "Admin Dashboard"

    expect(page).to have_content 'You are not allowed to access this page'
    expect(page).to_not have_content 'Admin Job Dashboard'
  end

  scenario 'allows a student to apply for a group application job opportunity with a resume and cover letter' do
    company = create_company
    create_job_opportunity(company: company)
    create_user(first_name: "Zach", cohort_id: cohort.id, github_id: "1234")
    mock_omniauth(base_overrides: {uid: "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')
    find('.add-job', visible: false).click
    click_on 'Apply'
    attach_file :application_cover_letter, File.join(fixture_path, 'coverletter.jpg')
    attach_file :application_resume, File.join(fixture_path, 'resume.pdf')
    click_on 'Apply for this position'

    expect(page).to have_content 'You have successfully applied!'
    within '.applied_for' do
      expect(page).to have_content 'Pivotal Labs'
    end

    within '.jobs_to_apply_for' do
      expect(page).to_not have_content 'Pivotal Labs'
    end
  end

  scenario 'does not allow a student to apply to a direct application job' do
    company = create_company
    create_job_opportunity(company: company, application_type: "Direct Application")
    create_user(first_name: "Zach", cohort_id: cohort.id, github_id: "1234")
    mock_omniauth(base_overrides: {uid: "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')
    find('.add-job', visible: false).click
    click_on 'Apply'
    # There should be a line about confirming the dialog that pops up here, but that would require JS

    within '.applied_for' do
      expect(page).to have_content 'Pivotal Labs'
    end

    within '.jobs_to_apply_for' do
      expect(page).to_not have_content 'Pivotal Labs'
    end
  end

  scenario 'allows an instructor to view the students applying for a particular job' do
    create_company
    job_op = create_job_opportunity
    student = create_user(first_name: "Zach", cohort_id: cohort.id, github_id: "1234")
    mock_omniauth(base_overrides: {uid: "1234"})
    apply_for_job(student, job_op, File.open(File.join(fixture_path, "resume.pdf")))

    sign_in(instructor)
    visit root_path
    click_on I18n.t('nav.job_opportunity')
    click_on "Admin Dashboard"
    click_on "Pivotal Labs"
    expect(page).to have_content "Zach"
  end

  scenario 'allows a student to create a company from the company drop down list' do
    create_user(first_name: "Zach", cohort_id: cohort.id, github_id: "1234")
    mock_omniauth(base_overrides: {uid: "1234"})
    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.job_opportunity')
    click_on 'Add a New Opportunity'
    click_on "Add a new company"

    fill_in :company_name, with: 'Quick Left'
    fill_in :company_contact_name, with: 'Ingrid'
    fill_in :company_contact_email, with: 'ingrid@example.com'
    click_on 'Add Company'

    expect(page).to have_content 'You successfully added a new company'
  end

  def apply_for_job(user, job_op, resume)
    Application.create!(user: user, job_opportunity: job_op, resume: resume)
  end

  # RSpec 3 has some weird new rules for pending

  # it 'allows student to delete their job opportunities' do
  #   cohort = create_cohort(name: "March gSchool")
  #   create_user(first_name: "Student", cohort_id: cohort.id, github_id: "1234")
  #
  #   mock_omniauth(base_overrides: {uid: "1234"})
  #
  #   visit root_path
  #   click_on I18n.t('nav.sign_in')
  #   click_on I18n.t('nav.job_opportunity')
  #
  #   create_job_opportunity
  #
  #   click_link 'Pivotal Labs'
  #   expect(page).to have_content('Pivotal Labs')
  #   click_link 'Delete Job'
  #   expect(page).not_to have_content('Pivotal Labs')
  # end

  # it 'allows student to edit their job opportunities' do
  #   cohort = create_cohort(name: "March gSchool")
  #   create_user(first_name: "Student", cohort_id: cohort.id, github_id: "1234")
  #
  #   mock_omniauth(base_overrides: {uid: "1234"})
  #
  #   visit root_path
  #   click_on I18n.t('nav.sign_in')
  #   click_on I18n.t('nav.job_opportunity')
  #
  #   create_job_opportunity
  #
  #   click_link 'Pivotal Labs'
  #   click_link 'Edit Job'
  #   fill_in(:job_opportunity_company_name, with: 'Viget Labs')
  #   click_on 'Update Job'
  #
  #   expect(page).not_to have_content('Pivotal Labs')
  #   expect(page).to have_content('Viget Labs')
  # end
end
