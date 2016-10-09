class VoteMailer < ActionMailer::Base
  default from: "from@example.com"

  def notify(voter, user)
    mail(to: user.email, subject: subject(voter))
  end

  def subject(voter)
    "#{voter.name.capitalize} voted on a film you submitted"
  end
end
