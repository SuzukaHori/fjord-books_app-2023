# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include UsersHelper
  test 'name_or_email' do
    user = build(:no_name)
    assert_equal 'no_name@example.com', user.name_or_email

    user.name = 'test_name'
    assert_equal 'test_name', user.name_or_email
  end
end
