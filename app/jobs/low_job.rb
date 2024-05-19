class LowJob
  include Sidekiq::Job

  sidekiq_options queue: :low

  def perform
    Rails.logger.info "Process LowJob"
  end
end