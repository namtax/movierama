require 'rails_helper'

RSpec.describe VotingBooth do 
  subject { described_class.new(john, movie) }

  let(:john) do
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

  let(:mail) { ActionMailer::Base.deliveries.first }

  before do 
    subject.vote(:like)
  end

  it 'sends vote notification email to expected email' do 
    expect(mail.to).to eq([dave.email])
  end

  it 'sends vote notification email with correct subject' do 
    expect(mail.subject).to eq('Bob voted on a film you submitted')
  end

  it 'notifies user of the film that was voted on' do 
    expect(mail.body).to include('Bob voted on Empire strikes back')
  end

  it 'notifies user of the type of vote' do 
    expect(mail.body).to include('Bob likes your film!!')
  end
end
