require 'rails_helper'

describe Application do
  describe "validations" do
    it "validates presence of user" do
      application = Application.new
      application.valid?

      expect(application.errors).to have_key(:user)

      application.user = new_user
      application.valid?

      expect(application.errors).to_not have_key(:user)
    end

    it "validates presence of job opportunity" do
      application = Application.new
      application.valid?

      expect(application.errors).to have_key(:job)

      application.job = new_job
      application.valid?

      expect(application.errors).to_not have_key(:job)
    end
  end
end
