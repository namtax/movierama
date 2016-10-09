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

  let(:mail)  { ActionMailer::Base.deliveries.first }

  it 'sends vote notification email to correct address' do 
    subject.vote(:like)
    expect(mail.to).to eq([dave.email])
  end
end
