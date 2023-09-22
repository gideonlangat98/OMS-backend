# config/application.rb

require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Oms
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.active_record.default_timezone = :local
    config.time_zone = "Nairobi"
    Time::DATE_FORMATS[:default] = "%Y-%m-%d %H:%M:%S"
    config.active_record.default_timezone = :utc

    # # Custom middleware classes
    # require_relative "../app/middleware/jwt_authentication"  # Modify the path to match your actual file location

    # config.middleware.use JwtAuthentication  # Use the middleware

    Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:3001'  # Replace with your frontend origin
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
      end
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
