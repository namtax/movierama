# Cast or withdraw a vote on a movie
class VotingBooth
  def initialize(user, movie)
    @user  = user
    @movie = movie
  end

  def vote(verdict)
    set = case verdict
      when :like then movie.likers
      when :hate then movie.haters
      else raise
    end

    unvote # to guarantee consistency
    set.add(user)
    create_vote
    _update_counts
    send_mail(verdict) if movie_user_subscribed?

    self
  end
  
  def unvote
    movie.likers.delete(user)
    movie.haters.delete(user)
    _update_counts
    self
  end

  private
  attr_reader :movie, :user

  def send_mail(verdict)
    VoteMailer.notify(user, movie, verdict).deliver
  end

  def create_vote
    Vote.create(movie: movie, user: user)
  end

  def _update_counts
    movie.update(
      liker_count: movie.likers.size,
      hater_count: movie.haters.size
    )
  end

  def movie_user_subscribed?
    movie.user.notifications == 'true'
  end
end
