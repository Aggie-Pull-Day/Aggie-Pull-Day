require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ListEaters
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.exceptions_app = self.routes

    config.assets.initialize_on_precompile = false


    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end

  class Application < Rails::Application
    config.load_defaults 6.0 # I'm using Rails 6 at the time of this article
    config.exceptions_app = self.routes # Add this line

    config.assets.initialize_on_precompile = false

  end

end
