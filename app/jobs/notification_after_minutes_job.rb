class NotificationAfterMinutesJob
  include Sidekiq::Job

  def perform
    Rails.logger.info "Sending notification after few minutes"
  end
end
