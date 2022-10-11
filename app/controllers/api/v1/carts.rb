module API
    module V1
      class Carts < Grape::API
          version 'v1', using: :path
          format :json
          prefix :api
          resource :carts do
            desc 'Return all Carts'
            
            #GET ALL CARTS 
            get :GetCarts do
              @cart = Cart.all
              if !@cart
                return "No Cart Found"
              else
                return @cart
              end
            end

            #GET ALL CARTS OF A SHOPPER
            get :ShopperCart do
              cart = Cart.where(shopper_id: params[:shopper_id])
              if cart == []
                return "Cart Not Found with given Shopper ID"
              else
                return cart
              end
            end

            #CREATES A NEW CART FOR A USER 
            post :CreateCart do 
                @product = Product.find(params[:product_id])
                prod_total = @product.price.to_i * params[:product_qty].to_i
                prod = [
                  {
                    "product_id" => "#{@product.id}",
                    "product_name" => "#{@product.name}",
                    "product_qty" => "#{params[:product_qty]}",  
                    "product_total" => "#{@product.price * params[:product_qty].to_i}",  
                    "retailer_id" => "99",  
                    "status" => "false"  
                  }  
                ]  
                @cart = Cart.new(
                    qty: "#{params[:product_qty]}",
                    total: @product.price.to_i * params[:product_qty].to_i, 
                    shopper_id: "#{params[:shopper_id]}",
                    products: prod
                )
                if @cart.save
                    return @cart
                else
                    return "Somethig Went Wrong"
                end
            end

            #UPDATE CART FOR A USER 
            post :UpdateCart do 
                @cart = Cart.where(shopper_id: params[:shopper_id])
                @product = Product.find(params[:product_id])
                prod_total = @product.price.to_i * params[:product_qty].to_i
                prod = @cart[0].products + [
                  {
                    "product_id" => "#{@product.id}",
                    "product_name" => "#{@product.name}",
                    "product_qty" => "#{params[:product_qty]}",  
                    "product_total" => "#{@product.price * params[:product_qty].to_i}",  
                    "retailer_id" => "99",  
                    "status" => "false"  
                  }  
                ] 
                @cart[0].products = prod
                @cart[0].total = @cart[0].total + prod_total
                @cart[0].qty = @cart[0].qty + params[:product_qty].to_i
                @cart[0].save
                return @cart[0]
            end
            #DELETE ANY CART OF ANY BRAND
            delete do
              Cart.where(shopper_id: params[:shopper_id]).destroy_all
              return "Cart Deleted"
            end
          end
      end
    end
  end
