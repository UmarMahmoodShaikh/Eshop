module API
    module V1
      class Base <Grape::API 
        mount API::V1::Products
        mount API::V1::Orders
        mount API::V1::Carts
        mount API::V1::Shoppers
        mount API::V1::Addresses
        mount API::V1::Chats
      end
    end
  end