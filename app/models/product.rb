require 'csv'
class Product < ApplicationRecord
    include Searchable
    # def self.import_csv!
    #     filepath = "/Users/umarmahmoodshk/products_202207281740.csv"
    #     res = CSV.parse(File.read(filepath), headers: true)
    #     res.each_with_index do |s ,ind|
    #         Product.create!(
    #             name: s["name"],
    #             price: s["price"],
    #             description: s["description"],
    #         )
    #     end
    # end


    # validates :name, :presence => true,uniqueness: true
    # validates :price, :presence => true
    # validates :description, :presence=> true
    belongs_to :brand
end