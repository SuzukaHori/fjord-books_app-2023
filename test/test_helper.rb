# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods
  include Devise::Test::IntegrationHelpers

  def sign_in_as_suzuka
    user = FactoryBot.create(:suzuka)
    sign_in(user)
    user
  end

  def sign_in_with_email_and_password
    user = FactoryBot.create(:suzuka)
    visit new_user_session_path
    fill_in 'Eメール', with: 'suzuka@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
    sleep 1
    user
  end
end
