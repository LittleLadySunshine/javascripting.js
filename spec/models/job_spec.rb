require 'rails_helper'

describe Job do
  describe "validations" do
    it "validates presence of company" do
      job = Job.new
      job.valid?

      expect(job.errors).to have_key(:company)

      job.company = new_company
      job.valid?

      expect(job.errors).to_not have_key(:company)
    end

    it "validates presence of poster" do
      job = Job.new
      job.valid?

      expect(job.errors).to have_key(:poster)

      job.poster = new_user
      job.valid?

      expect(job.errors).to_not have_key(:poster)
    end
  end

  describe "#students_applying" do
    it "returns the students that are applying to a job" do
      student = create_user
      job = create_job
      new_application(user: student, job: job).tap do |a|
        a.resume = File.open(File.join(fixture_path, 'resume.pdf'))
      end.save!

      expect(job.applicants ).to match_array([student])
    end
  end

  describe ".opportunities_for" do
    it "finds all the job opportunities that are public or posted by the user" do
      admin = create_user
      student = create_user
      other_student = create_user

      public_job = create_job(poster: admin, visibility: "Public")
      private_job = create_job(poster: student, visibility: "Private")

      expect(Job.opportunities_for(student)).to eq([public_job, private_job])
      expect(Job.opportunities_for(other_student)).to eq([public_job])
    end
  end
end
