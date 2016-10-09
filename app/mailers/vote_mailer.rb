class VoteMailer < ActionMailer::Base
  default from: "from@example.com"

  def notify(voter, movie)
    @movie = movie 
    @user  = movie.user
    @voter = voter
    
    mail(to: movie.user.email, subject: subject(voter))
  end

  def subject(voter)
    "#{voter.name.capitalize} voted on a film you submitted"
  end
end
