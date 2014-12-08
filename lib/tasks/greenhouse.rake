namespace :greenhouse do

  desc "Populates the greenhouse applications for upcoming cohorts"
  task harvest: :environment do
    Cohort.upcoming.each do |cohort|
      GreenhouseHarvester.new(cohort).harvest
    end
  end

end
