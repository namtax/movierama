require 'rails_helper'
require 'capybara/rails'
require 'support/pages/home'
require 'support/with_user'

RSpec.describe 'notifications/disable/:id', type: :feature do
  with_auth_mock

  let(:page) { Pages::Home.new }
  let(:user) { User.all.first }

  before { page.open }

  context 'logged in' do 
    with_logged_in_user

    it 'notifies user they are unsubscribed' do 
      visit "notifications/disable/#{user.id}"
      expect(page).to have_content('You have been unsubscribed from notifications')
    end

    it 'updates users notification settings' do 
      visit "notifications/disable/#{user.id}"
      expect(user.load!.notifications).to eq 'false'
    end
  end
end
