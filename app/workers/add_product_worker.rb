class AddProductWorker
  # require 'csv'
  # include Sidekiq::Worker
  # sidekiq_options retry: false

  # def perform(csv_file)
  #   CSV.foreach(csv_file, headers: true) do |product|
  #       Product.create(name: product[0], price: product[1], description: product[2], brand_id: product[3], quantity: product[4], availability: product[5], subcategory_id: product[6])
  #   end
  # end
end