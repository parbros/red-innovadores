# encoding: utf-8

Refinery::I18n.configure do |config|
  config.current_locale = :es
  config.default_locale = :es
  config.default_frontend_locale = :es
  config.enabled = true
  config.frontend_locales = [:es]
  config.locales = { :es=>"Español"}
end
