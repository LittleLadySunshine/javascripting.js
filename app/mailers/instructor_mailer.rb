class InstructorMailer < ActionMailer::Base
  default :from => 'instructors@gschool.it', :bcc => 'info@gschool.it'

  helper :markdown

  def one_on_one_schedule(instructor, appointments)
    @instructor, @appointments = instructor, appointments
    mail(:to => instructor.email, :subject => "Your one-on-one time for #{Date.today.strftime("%-m/%-d/%Y")}")
  end
end
