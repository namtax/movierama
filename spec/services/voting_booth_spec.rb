require 'rails_helper'

RSpec.describe VotingBooth do 
  subject      { described_class.new(bob, movie) }
  let(:bob)    { double } 
  let(:movie)  { double(likers: Set.new, haters: Set.new, update: nil) }
  let(:mailer) { double }

  describe '#vote' do 
    before do 
      allow(VoteMailer).to receive(:notify).with(bob, movie, :like)
        .and_return(mailer)
    end

    it 'sends vote notification email' do 
      expect(mailer).to receive(:deliver)
      subject.vote(:like)
    end
  end
end
