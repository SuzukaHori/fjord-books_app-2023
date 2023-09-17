# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include UsersHelper

  def current_user_name(user)
    [user.name, user.email].find(&:present?)
  end

  test 'name_or_email' do
    user = User.new(
      email: 'test@example.com',
      name: '',
      password: 'password'
    )
    assert_equal 'test@example.com', user.name_or_email

    user.name = 'suzuka'
    assert_equal 'suzuka', user.name_or_email
  end
end
