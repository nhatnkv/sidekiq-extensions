class NotificationJob
  include Sidekiq::Job

  def perform(product_id)
    product = Product.find(product_id)

    Rails.logger.info "Sending notification for product #{product.id}"
  end
end
