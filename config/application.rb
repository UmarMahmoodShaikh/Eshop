require_relative "boot"

require "rails/all"
# GOOGLE CLOUD STORAGE
require "google/cloud/storage"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module Eshop
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    # Configuration for the application, engines, and railties goes here.

    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.paths.add File.join('app ', 'api'), glob: File.join('**', '*.rb')
    config.paths.add File.join('app ', 'api'), glob: File.join('**', '*.erb')
    # config.autoload_paths += Dir[Rails.root.join('app','api', '*')]
    config.active_job.queue_adapter = :sidekiq
  config.action_cable.mount_path = '/cable'
  config.action_cable.allow_same_origin_as_host = false
   config.action_cable.disable_request_forgery_protection = true
  config.public_file_server.enabled = true
    
    end
end
