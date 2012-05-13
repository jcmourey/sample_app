class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  include HttpAcceptLanguage
  include SessionsHelper

  def set_locale
    I18n.locale = params[:locale] \
               || request.preferred_language_from(I18n.available_locales) \
               || request.compatible_language_from(I18n.available_locales)   \
               || I18n.default_locale
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end

end
