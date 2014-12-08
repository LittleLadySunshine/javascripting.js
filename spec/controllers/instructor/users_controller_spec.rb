require "rails_helper"

describe Instructor::UsersController do
  let!(:cohort) { create_cohort }

  def sign_in_instructor
    sign_in(create_instructor)
  end

  def check_instructor_authorized(&request)
    request.call
    expect(response).to redirect_to(root_path)

    sign_in(create_user)
    request.call
    expect(response).to redirect_to(root_path)

    sign_in(create_instructor)
    request.call
    expect(response.status).to_not redirect_to(root_path)
  end

  describe "GET #new" do
    it "requires a user to be an instructor" do
      check_instructor_authorized { get 'new', :cohort_id => cohort.id }
    end
  end

  describe "POST #create" do
    let(:valid_params) do
      {
        first_name: "Johnny",
        last_name: "Smith",
        email: "email@example.com",
        cohort_id: cohort.id,
        role: 'student',
      }
    end

    it "requires a user to be an instructor" do
      check_instructor_authorized { post 'create', cohort_id: cohort.id, user: valid_params }
    end

    it "creates a student" do
      sign_in_instructor

      expect { post( 'create', user: valid_params ) }.to change { User.count }.by 1

      user = User.last
      expect(user.first_name).to eq('Johnny')
      expect(user.last_name).to eq('Smith')
      expect(user.email).to eq('email@example.com')
      expect(user.cohort_id).to eq(cohort.id)
    end

    it "sends an email to the user inviting them if specified" do
      sign_in_instructor

      expect {
        post(
          'create',
          cohort_id: cohort.id,
          user: valid_params,
          send_welcome_email: 1,
        )
      }.to change { ActionMailer::Base.deliveries.size }.by 1

      created_email = ActionMailer::Base.deliveries.last
      expect(created_email.to).to eq ['email@example.com']
      expect(created_email.bcc).to eq ['info@gschool.it']
    end

    it 'does not send an email when creation fails' do
      ActionMailer::Base.deliveries.clear

      post 'create', :cohort_id => cohort.id, :student => {}

      expect(ActionMailer::Base.deliveries.size).to eq(0)
    end
  end
end
