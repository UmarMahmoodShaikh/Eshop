module API
    module V1
      class Orders < Grape::API
          # version 'v1', using: :path
          version 'v1', using: :path
          format :json
          prefix :api
          resource :orders do
            desc 'Return all Orders'
            
            #GET ALL ORDES OF A SPECIFIC RETAILER
            get :RetailerOrder do
              @order = Order.where(retailer_id: params[:retailer_id])
              return @order
            end

            #GET ALL ORDES OF A SPECIFIC SHOPPER
            get :ShopperOrder do
              @order = Order.where(shopper_id: params[:shopper_id])
              return @order
            end

            #GET ALL ORDES OF A SPECIFIC RETAILER WITH TRUE STATUS
            get :RetailerOrderTrue do
              @order = Order.where(retailer_id: params[:retailer_id], status: true)
              return @order
            end

            #GET ALL ORDES OF A SPECIFIC SHOPPER WITH TRUE STATUS
            get :ShopperOrderTrue do
              @order = Order.where(shopper_id: params[:shopper_id], status: true)
              return @order
            end


            #GET ALL ORDES OF A SPECIFIC RETAILER WITH TRUE STATUS
            get :RetailerOrderFalse do
              @order = Order.where(retailer_id: params[:retailer_id], status: false)
              return @order
            end

            #GET ALL ORDES OF A SPECIFIC SHOPPER WITH TRUE STATUS
            get :ShopperOrderFalse do
              @order = Order.where(shopper_id: params[:shopper_id], status: false)
              return @order
            end

            #CREATES A NEW ORDER OF A SHOPPER AND DELETE IT'S CART ITEMS
            post :CreateOrder do
              @cart = Cart.where(shopper_id: params[:shopper_id])
              @order = Order.new(
                shopper_id: "#{params[:shopper_id]}", 
                shopper_address: "#{params[:shopper_address]}", 
                retailer_id: "#{params[:retailer_id]}", 
                products: @cart[0].products, 
                grand_total: @cart[0].total
              )
              if @order.save
                Cart.where(shopper_id: params[:shopper_id]).destroy_all
                return "New Order Placed and all cart items are Destroyed"
              else
                return "Something went wrong"
              end
            end

            #UPDATE THE STATUS OF AN ORDER USING COMPANY API CALL
            put :UpdateStatus do
              @order = Order.find(params[:id]).update(status: params[:status])
              return @order
            end

            #DELETE ALL ORDES OF A SPECIFIC SHOPPER WITH SPECIFIC STATUS
            delete do
              Order.where(shopper_id: params[:shopper_id], status: params[:status]).destroy_all
              return 'Order Deleted'
            end

          end
      end
    end
  end 
