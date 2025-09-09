require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1
    config.active_job.queue_adapter = :sidekiq
    # mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

    config.autoload_lib(ignore: %w[assets tasks])
  end
end