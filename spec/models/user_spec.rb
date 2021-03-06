require 'rails_helper'

describe User do
  it 'validates the presence of a cohort if the user is a student' do
    user = User.new
    user.valid?
    expect(user.errors[:cohort]).to be_present
    user.role = :instructor
    user.valid?
    expect(user.errors[:cohort]).to be_blank
  end

  it 'validates that linkedin is a full url' do
    user = User.new
    user.valid?
    expect(user.errors[:linkedin]).to be_empty
    user.linkedin = "www.linkedin.com"
    user.valid?
    expect(user.errors[:linkedin]).to include("must be a full URL that starts with 'http'")
    user.linkedin = "http://www.linkedin.com"
    user.valid?
    expect(user.errors[:linkedin]).to be_empty
    user.linkedin = "https://www.linkedin.com"
    user.valid?
    expect(user.errors[:linkedin]).to be_empty
  end

  it 'validates uniqueness of email' do
    create_user(email: 'sue@example.com')

    user = new_user(email: 'sue@example.com')

    expect(user).to_not be_valid

    user.email = 'bob@example.com'

    expect(user).to be_valid
  end

  it 'requires an email' do
    user = new_user
    expect(user).to be_valid

    user.email = nil
    expect(user).to_not be_valid
  end

  it 'has a full name' do
    user = User.new(first_name: 'Bob', last_name: 'Wills')
    expect(user.full_name).to eq 'Bob Wills'
  end

  it 'can determine if the user is an instructor' do
    user = new_user

    expect(user).to be_student

    user.role = :instructor
    expect(user).to be_instructor
  end
end
