class DailyVotes < BaseModel
  include Ohm::Timestamps


  attribute :movie_name
  attribute :liker_count
  attribute :hater_count
end
