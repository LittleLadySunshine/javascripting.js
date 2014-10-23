class StudentMailer < ActionMailer::Base
  default :from => 'instructors@gschool.it', :bcc => 'info@gschool.it'

  helper :markdown

  def invitation(email)
    @email = email
    mail(:to => email, :subject => I18n.t('student_mailer.invitation.subject'))
  end

  def action_plan_entry(creator, entry)
    @entry = entry
    mail(
      from: creator.email,
      bcc: entry.cohort.instructors.map(&:email) - [creator.email],
      to: entry.user.email,
      subject: "gSchool Action Plan: #{entry.created_at.strftime('%-m/%-d/%Y')}"
    )
  end
end
