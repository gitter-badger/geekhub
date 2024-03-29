require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Backend
  class Application < Rails::Application

    ## enables sessions
    # config.middleware.use Rack::Session::Cookie
    ## OR--
    config.session_store
    config.api_only = false

    config.active_record.raise_in_transactional_callbacks = true
  end
end
