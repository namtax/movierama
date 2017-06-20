class Vote < BaseModel
  include Ohm::Timestamps
  
  reference :user,  :User
  reference :movie, :Movie
end

