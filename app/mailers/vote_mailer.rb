class VoteMailer < ActionMailer::Base
  default from: 'notifications@movierama.com'

  def notify(voter, movie, verdict)
    @movie   = movie 
    @user    = movie.user
    @voter   = voter
    @verdict = verdict

    mail(to: movie.user.email, subject: subject(voter))
  end

  def subject(voter)
    "#{voter.name.titleize} voted on a film you submitted"
  end
end
