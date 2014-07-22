require 'rails_helper'

feature 'Job Management' do
  let!(:cohort) { create_cohort(:name => 'Boulder gSchool') }
  let!(:instructor) { create_user(:first_name => "Instructor", :last_name => "User", :github_id => '987', :role_bit_mask => 1, :cohort_id => cohort.id) }

  scenario 'a student cannot view the gSchool employment page if the cohort is not ready' do
    cohort = create_cohort(:name => "March gSchool", :employment_phase => false)
    create_user(:first_name => "Student", :cohort_id => cohort.id, :github_id => "1234")
    
    mock_omniauth(:base_overrides => {:uid => "1234"})
    visit root_path

    click_on I18n.t('nav.sign_in')
    expect(page).to have_no_content(I18n.t('nav.jobs'))

    visit jobs_path

    expect(page).to have_no_content "gSchool Employment"
    expect(page).to have_no_content "Available Jobs to Apply to"
  end

  scenario 'allows student to view the gSchool employment page if the cohort allows' do
    cohort = create_cohort(:name => "March gSchool")
    create_user(:first_name => "Student", :cohort_id => cohort.id, :github_id => "1234")

    mock_omniauth(:base_overrides => {:uid => "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.jobs')

    expect(page).to have_content "gSchool Employment"
    expect(page).to have_content "Available Jobs to Apply to"
  end

  scenario 'students can post a job' do
    cohort = create_cohort(:name => "March gSchool")
    create_company(:name => "Sensei Academy")
    create_user(:first_name => "Student", :cohort_id => cohort.id, :github_id => "1234")

    mock_omniauth(:base_overrides => {:uid => "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.jobs')

    click_on 'Add a New Job'
    select "Sensei Academy", :from => :job_company_id
    fill_in :job_application_due_date, :with => '07/30/2014'
    fill_in :job_location, :with => 'Denver'
    fill_in :job_salary, :with => '80,000'
    fill_in :job_description_link, :with => 'http://example.com/job-description'
    select "Direct Application", :from => :job_application_type
    select "Public", :from => :job_visibility
    fill_in :job_job_title, :with => 'Software Engineer'
    click_on 'Create Job Opportunity'

    expect(page).to have_content('Job Opportunity Successfully Created')
    within('.jobs') do
      expect(page).to have_content('Sensei Academy')
    end
  end

  scenario 'students can post a private job' do
    cohort = create_cohort(:name => "gSchool")
    create_company
    student = create_user(:cohort_id => cohort.id, :github_id => "1234")
    other_student = create_user(:cohort_id => cohort.id, :github_id => "4321")

    mock_user_login(student)

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.jobs')

    click_on 'Add a New Job'
    select "Pivotal Labs", :from => :job_company_id
    fill_in :job_application_due_date, :with => '07/30/2014'
    fill_in :job_location, :with => 'Denver'
    fill_in :job_salary, :with => '80,000'
    select "Direct Application", :from => :job_application_type
    select "Private", :from => :job_visibility
    fill_in :job_job_title, :with => 'Software Engineer'
    click_on 'Create Job Opportunity'

    expect(page).to have_content('Job Opportunity Successfully Created')
    within(".jobs") do
      expect(page).to have_content('Pivotal Labs')
    end

    click_on "Sign Out"

    mock_user_login(other_student)
    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.jobs')

    within(".jobs") do
      expect(page).to_not have_content('Pivotal Labs')
    end
  end

  scenario 'students can add a job to their shortlist of jobs to apply to' do
    cohort = create_cohort(:name => "March gSchool")
    create_job
    create_user(:first_name => "Student", :cohort_id => cohort.id, :github_id => "1234")

    mock_omniauth(:base_overrides => {:uid => "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.jobs')
    find('.add-job', :visible => false).click

    within(".jobs_to_apply_for") do
      expect(page).to have_content 'Pivotal Labs'
    end

    visit jobs_path
    find('.add-job', :visible => false).click
    expect(page).to have_content 'You already added this job'
  end

  scenario 'instructors can view the admin dashboard for employment' do
    sign_in(instructor)

    visit root_path
    click_on I18n.t('nav.jobs')
    create_job
    click_on "Admin Dashboard"

    expect(page).to have_content 'Admin Job Dashboard'
    click_link 'Pivotal Labs'
  end

  scenario 'students cannot view the admin dashboard for employment' do
    cohort = create_cohort(:name => "March gSchool")
    create_user(:first_name => "Student", :cohort_id => cohort.id, :github_id => "1234")
    mock_omniauth(:base_overrides => {:uid => "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.jobs')
    click_on "Admin Dashboard"

    expect(page).to have_content 'You are not allowed to access this page'
    expect(page).to_not have_content 'Admin Job Dashboard'
  end

  scenario 'allows a student to apply for a group application job with a resume and cover letter' do
    company = create_company(:name => "company-name")
    create_job(:company => company)
    create_user(:first_name => "Zach", :cohort_id => cohort.id, :github_id => "1234")
    mock_omniauth(:base_overrides => {:uid => "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.jobs')
    find('.add-job', :visible => false).click
    click_on 'Apply'
    attach_file :application_resume, File.join(fixture_path, 'resume.pdf')
    click_on 'Apply for this position'

    expect(page).to have_content 'You have successfully applied!'
    within '.applied_for' do
      expect(page).to have_content 'company-name'
    end

    within '.jobs_to_apply_for' do
      expect(page).to_not have_content 'company-name'
    end
  end

  scenario "students can re-upload their resume and cover letter for a group application" do
    company = create_company(:name => "company-name")
    job = create_job(:company => company)
    student = create_user
    application = apply_for_job(student, job, File.open(File.join(fixture_path, "resume.pdf")))
    mock_user_login(student)

    visit root_path
    click_on I18n.t("nav.sign_in")
    click_on I18n.t("nav.jobs")
    click_on "job-dashboard-action"

    within '.applied_for' do
      expect(page).to have_content 'company-name'
      expect(find_link("download-application#{application.id}-action")["href"]).to match("resume.pdf")
    end

    click_on "edit-application#{application.id}-action"

    attach_file :application_resume, File.join(fixture_path, "other_resume.pdf")
    click_on "save-application-action"

    expect(find_link("download-application#{application.id}-action")["href"]).to match("other_resume.pdf")
  end

  scenario 'students applying to a direct application job marks the jobs as applied for' do
    company = create_company
    create_job(:company => company, :application_type => "Direct Application")
    create_user(:first_name => "Zach", :cohort_id => cohort.id, :github_id => "1234")
    mock_omniauth(:base_overrides => {:uid => "1234"})

    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.jobs')
    find('.add-job', :visible => false).click
    click_on 'Apply'
    # There should be a line about confirming the dialog that pops up here, but that would require JS

    within '.applied_for' do
      expect(page).to have_content 'Pivotal Labs'
    end

    within '.jobs_to_apply_for' do
      expect(page).to_not have_content 'Pivotal Labs'
    end
  end

  scenario 'instructors can view the students applying for a particular job' do
    create_company
    job = create_job
    student = create_user(:first_name => "Zach", :cohort_id => cohort.id, :github_id => "1234")
    mock_omniauth(:base_overrides => {:uid => "1234"})
    apply_for_job(student, job, File.open(File.join(fixture_path, "resume.pdf")))

    sign_in(instructor)
    visit root_path
    click_on I18n.t('nav.jobs')
    click_on "Admin Dashboard"
    click_on "Pivotal Labs"
    expect(page).to have_content "Zach"
    expect(page).to have_selector("a[download=download]", text: "Resume")
  end

  scenario 'users posting a job can create a company' do
    create_user(:first_name => "Zach", :cohort_id => cohort.id, :github_id => "1234")
    mock_omniauth(:base_overrides => {:uid => "1234"})
    visit root_path
    click_on I18n.t('nav.sign_in')
    click_on I18n.t('nav.jobs')
    click_on 'Add a New Job'
    click_on "Add a new company"

    fill_in :company_name, :with => 'Quick Left'
    fill_in :company_contact_name, :with => 'Ingrid'
    fill_in :company_contact_email, :with => 'ingrid@example.com'
    click_on 'Add Company'

    expect(page).to have_content 'You successfully added a new company'
  end

  scenario "students can remove a job from the 'jobs I will apply for' section" do
    create_company
    create_job(:job_title => "banana-master")
    student = create_user

    mock_user_login(student)
    visit root_path
    click_on I18n.t("nav.sign_in")
    click_on I18n.t("nav.jobs")
    find(".add-job", :visible => false).click
    within(".jobs_to_apply_for") do
      expect(page).to have_content("banana-master")
    end

    find(".remove-job-action", :visible => false).click
    expect(page).to have_content "Job removed from shortlist"
    within(".jobs_to_apply_for") do
      expect(page).to_not have_content("banana-master")
    end
  end

  def apply_for_job(user, job, resume, cover_letter = nil)
    Application.create!(
      :user => user,
      :job => job,
      :resume => resume,
      :status => Application.statuses[:applied],
    )
  end
end