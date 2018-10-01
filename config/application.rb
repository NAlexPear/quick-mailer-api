require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module QuickMailerApi
  class Application < Rails::Application
    EMAIL_DOMAIN = ENV.fetch('DOMAIN_NAME', 'example.com')

    config.load_defaults 5.2
    config.action_mailer.default_options = { from: "notifications@#{EMAIL_DOMAIN}" }
    config.api_only = true
    config.active_job.queue_adapter = :sidekiq
  end
end
