# frozen_string_literal: true

class ApplicationController < ActionController::Base
  around_action :set_locale

  private

  def set_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
