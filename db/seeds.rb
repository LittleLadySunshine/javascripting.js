Cohort.destroy_all
User.destroy_all

cohort = Cohort.create!(
  :name => "Cohort 1",
  :start_date => "01/01/2001",
  :end_date => "06/01/2001",
  :directions => "<p>This is a direction</p>",
  :google_maps_location => "https://www.google.com/maps/embed?pb=!1m5!3m3!1m2!1s0x876bec26e4137699%3A0xf9d8bd928167d4d5!2s1035+Pearl+St%2C+Boulder%2C+CO+80302!5e0!3m2!1sen!2sus!4v1387232536923",
  :curriculum_site_url => "http://localhost:3002"
)

print "What's your email address (needs to be valid on GitHub): "
email = $stdin.gets.chomp
print "What's your GitHub username associated with this email (needs to be valid on GitHub): "
username = $stdin.gets.chomp

User.create!(
  first_name: "Admin",
  last_name: "User",
  email: email,
  github_username: username,
  cohort: cohort,
  role: :instructor
)
