require 'rails_helper'

RSpec.describe VoteMailer do 
  let(:bob) do
    User.create(
      uid:  'null|67890',
      name: 'Bob',
      email: 'bob@site.com'
    )
  end

  let(:dave) do
    User.create(
      uid:  'null|67891',
      name: 'Dave',
      email: 'dave@site.com'
    )
  end

  let(:movie) do 
    Movie.create(
      title:        'Empire strikes back',
      description:  'Who\'s scruffy-looking?',
      date:         '1980-05-21',
      user:         dave,
      liker_count:  50,
      hater_count:  2
    )
  end

  let(:mail)    { described_class.notify(bob, movie, verdict) }
  let(:verdict) {  } 

  describe '#notify' do
    it 'sends vote notification email to expected email' do 
      expect(mail.to).to eq([dave.email])
    end

    it 'sends vote notification email from expected email' do 
      expect(mail.from).to eq(['notifications@movierama.com'])
    end

    it 'sends vote notification email with correct subject' do 
      expect(mail.subject).to eq('Bob voted on a film you submitted')
    end

    it 'notifies user of the film that was voted on' do 
      expect(mail.body).to include('Bob voted on Empire Strikes Back')
    end

    context 'verdict' do 
      context 'like' do 
        let(:verdict) { :like }
        it { expect(mail.body).to include('Bob likes your film!!') }
      end

      context 'hate' do 
        let(:verdict) { :hate }
        it { expect(mail.body).to include('Bob hates your film!!') }
      end
    end
  end
end
