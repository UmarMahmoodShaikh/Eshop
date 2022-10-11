class RemoveCartWorker
  # include Sidekiq::Worker
  # sidekiq_options retry: false

  # def perform
  #   Cart.where(shopper_id: Redis.current.get("shopper_id")).destroy_all
  # end

end