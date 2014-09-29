class StudentMailer < ActionMailer::Base
  default :from => 'instructors@gschool.it', :bcc => 'info@gschool.it'

  def invitation(email)
    mail(:to => email, :subject => I18n.t('student_mailer.invitation.subject'))
  end
end
