require 'sidekiq'
require 'sidekiq-status'
require "sidekiq/throttled"

Sidekiq.configure_client do |config|
  # accepts :expiration (optional)
  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes.to_i

  config.client_middleware do |chain|
    chain.add Sidekiq::Debouncer::Middleware::Client
  end
end

Sidekiq.configure_server do |config|
  # accepts :expiration (optional)
  Sidekiq::Status.configure_server_middleware config, expiration: 30.minutes.to_i

  # accepts :expiration (optional)
  Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes.to_i

  config.client_middleware do |chain|
    chain.add Sidekiq::Debouncer::Middleware::Client
  end

  config.server_middleware do |chain|
    chain.add Sidekiq::Debouncer::Middleware::Server
  end
end