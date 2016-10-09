class VoteMailer < ActionMailer::Base
  default from: "from@example.com"

  def notify(user)
    mail(to: user.email)
  end
end
