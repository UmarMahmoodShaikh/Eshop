class BaseWorkerJob
  # include Sidekiq::Job

  # def perform(*args)
  #   # Do something
  #   BaseWorkerJob.perform_in(1.minute.from_now,'Bob', 5)
  # end
end
