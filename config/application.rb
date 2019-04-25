require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module GeeksHub
  class Application < Rails::Application  
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)

  	config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end
  end


end
