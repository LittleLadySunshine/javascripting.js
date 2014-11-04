require "rails_helper"

describe DailyPlansController do
  let!(:cohort) { create_cohort }

  def check_instructor_authorized(&request)
    sign_in(create_instructor)
    request.call
    expect(response.status).to_not redirect_to(root_path)
  end

  def check_student_unauthorized(&request)
    sign_in(create_user)
    request.call
    expect(response).to redirect_to(root_path)
  end

  def check_public_unauthorized(&request)
    request.call
    expect(response).to redirect_to(root_path)
  end

  describe "GET #new" do
    it "allows instructors" do
      check_instructor_authorized { get 'new', cohort_id: cohort.id }
    end
    it "does not allow the public" do
      check_public_unauthorized { get 'new', cohort_id: cohort.id }
    end
    it "does not allow students" do
      check_student_unauthorized { get 'new', cohort_id: cohort.id }
    end
  end
end
