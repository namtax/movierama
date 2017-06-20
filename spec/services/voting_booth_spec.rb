require 'rails_helper'

RSpec.describe VotingBooth do 
  subject      { described_class.new(voter, movie) }

  describe '#vote' do 
    context 'mailer' do
      let(:movie)  { double(id: 1, likers: Set.new, haters: Set.new, update: nil, user: dave) }
      let(:dave)   { double(id: 2, notifications: setting) }
      let(:voter)  { double(id: 3) } 
      let(:mailer) { double }

      before do 
        allow(VoteMailer).to receive(:notify).with(voter, movie, :like)
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
        it 'does not send vote notification email' do 
          expect(mailer).to_not receive(:deliver)
          subject.vote(:like)
        end
      end
    end


    context 'vote model is created' do 
      subject { described_class.new(@voter, @movie) }

      before do
        @alice = User.create(
          uid:  'null|12345',
          name: 'Alice'
        )
        @voter = User.create(
          uid:  'null|67890',
          name: 'Bob'
        )
        @movie = Movie.create(
          title:        'Empire strikes back',
          description:  'Who\'s scruffy-looking?',
          date:         '1980-05-21',
          user:         @alice,
          liker_count:  50,
          hater_count:  2
        )
      end

      it 'creates vote model' do 
        expect { subject.vote(:like) }.to change { Vote.all.size }.by(1)
      end

      it 'creates vote model with correct user' do 
        subject.vote(:like) 
        expect(Vote[1].user).to eq(@voter)
      end

      it 'creates vote model with correct movie' do 
        subject.vote(:like) 
        expect(Vote[1].movie).to eq(@movie)
      end
    end
  end
end
