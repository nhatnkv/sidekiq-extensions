class CriticalJob
  include Sidekiq::Job
  include Sidekiq::Status::Worker
  include Sidekiq::Throttled::Job

  sidekiq_options(
    queue: :critical,
    debounce: {
      by: -> (args) { args[0] },
      time: 2
    }
  )

  # This job will be processed only once every 5 seconds
  # and only one job will be processed at a time
  # for each unique uuid
  # This is useful
  # when you want to limit the number of jobs processed at a time
  sidekiq_throttle(
    concurrency: { limit: 1, key_suffix: -> (uuid) { uuid } },
    threshold: { limit: 1, period: 5, key_suffix: -> (uuid) { uuid } }
  )

  def perform(uuid)
    sleep 5
    Rails.logger.info "Process CriticalJob for uuid #{uuid}"
  end
end
