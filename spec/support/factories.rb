module ObjectFactories

  def create_pairing(overrides = {})
    defaults = {
      feedback: 'great job!',
      paired_on: Date.today,
    }
    Pairing.create!(defaults.merge(overrides))
  end

  def create_staffing(overrides = {})
    new_staffing(overrides).tap do |u|
      u.save!
    end
  end

  def new_staffing(overrides = {})
    defaults = {
      :status => :active
    }
    Staffing.new(defaults.merge(overrides))
  end

  def create_instructor(overrides = {})
    new_user(overrides).tap do |u|
      u.role = :instructor
      u.cohort = nil
      u.save!
    end
  end

  def create_user(overrides = {})
    new_user(overrides).tap do |u|
      u.save!
    end
  end

  def new_user(overrides = {})
    defaults = {
      :email => "user#{rand}@example.com",
      :first_name => 'John',
      :last_name => 'Smith',
      :cohort => new_cohort
    }
    User.new(defaults.merge(overrides))
  end

  def create_cohort(overrides = {})
    new_cohort(overrides).tap do |c|
      c.save!
    end
  end

  def new_cohort(overrides = {})
    defaults = {
      :name => "gSchool#{rand(1000)}",
      :directions => "<p>Some directions</p>",
      :google_maps_location => 'https://google.com',
      :start_date => "01/01/2001",
      :end_date => "06/01/2001"
    }
    Cohort.new(defaults.merge(overrides))
  end

  def create_exercise(overrides = {})
    new_exercise(overrides).tap do |a|
      a.save!
    end
  end

  def new_exercise(overrides = {})
    defaults = {
      :name => 'Arrays and stuff',
      :github_repo => 'http://example.com'
    }

    Exercise.new(defaults.merge(overrides))
  end

  def new_submission(overrides = {})
    defaults = {
      :github_repo_name => 'repo'
    }

    Submission.new(defaults.merge(overrides))
  end

  def create_submission(overrides = {})
    new_submission(overrides).tap do |s|
      s.save!
    end
  end
end
