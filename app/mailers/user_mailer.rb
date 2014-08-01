class UserMailer < ActionMailer::Base
  default from: 'notifications@example.com'

  def welcome_email
    mail(to: "user@example.com", subject: 'result = true')
  end
end
