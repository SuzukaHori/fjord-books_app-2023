# frozen_string_literal: true

module UsersHelper
  def current_user_name(user)
    [user.name, user.email].find(&:present?)
  end

  def display_username_or_email(model)
    (model.user.name.presence || model.user.email)
  end
end
