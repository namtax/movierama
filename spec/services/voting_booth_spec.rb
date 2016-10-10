require 'rails_helper'

RSpec.describe VotingBooth do 
  subject      { described_class.new(bob, movie) }
  let(:movie)  { double(likers: Set.new, haters: Set.new, update: nil, user: dave) }
  let(:dave)   { double(notifications: setting) }
  let(:bob)    { double } 
  let(:mailer) { double }

  describe '#vote' do 
    before do 
      allow(VoteMailer).to receive(:notify).with(bob, movie, :like)
        .and_return(mailer)
    end

    context 'user subscribed for notifications' do 
      let(:setting) { 'true' }
      it 'sends vote notification email' do 
        expect(mailer).to receive(:deliver)
        subject.vote(:like)
      end
    end

    context 'user not subscribed for notifications' do 
      let(:setting) { 'false' }
      it 'sends vote notification email' do 
        expect(mailer).to_not receive(:deliver)
        subject.vote(:like)
      end
    end
  end
end
