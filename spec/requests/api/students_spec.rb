require 'rails_helper'

describe "Students API" do
  describe 'when the github username is not present on the user' do
    it 'updates the github username' do
      cohort = create_cohort
      student1 = create_user(
        email: 'user1@example.com',
        cohort: cohort,
        github_username: "someuser1"
      )
      student2 = create_user(
        email: 'user2@example.com',
        cohort: cohort,
        github_username: "someuser2"
      )

      get "/api/cohorts/#{cohort.to_param}/students"

      response_json = JSON.parse(response.body, symbolize_names: true)
      expect(response_json.length).to eq(2)
      usernames = response_json.map{|user| user[:github_username] }
      expect(usernames).to match_array(["someuser1", "someuser2"])
    end
  end
end
