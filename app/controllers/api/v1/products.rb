module API
    module V1
      class Products < Grape::API
          version 'v1', using: :path
          format :json
          prefix :api
          resource :products do
            desc 'Return all Products'
            
            #GET ALL PRODUCTS
            get do
              product = Product.all
              if product == []
                return "No product added yet"
              else
                return product
              end
            end

            #GET ALL PRODUCTS OF A CERTAIN BRAND
            get :BrandProduct do
              product = Product.where(brand_id: params[:brand_id])
              if product == []
                return "Product Not Found with given Brand"
              else
                return product
              end
            end

            #GET ALL PRODUCTS OF A CERTAIN SUB-CATEGORY
            get :SubCategoryProduct do
              product = Product.where(subcategory_id: params[:subcategory_id])
              if product == []
                return "Product Not Found with given SubCategory"
              else
                return product
              end
            end

            #GET ALL PRODUCTS WHICH ARE AVAILABLE
            get :AvailableProduct do
              product = Product.where(availability: true)
              if product == []
                return "No Product is available currently"
              else
                return product
              end
            end

            #GET ALL PRODUCTS WHICH ARE UNAVAILABLE
            get :UnAvailableProduct do
              product = Product.where(availability: false)
              if product == []
                return "No Product is available currently"
              else
                return product
              end
            end

            get :IgniteProduct do
              client = Ignite::Client.new(username: "e-shop-ignite", password: "eshopignite123",host:"2b07e895-1621-4111-bee3-354ae7ba8602.gridgain-nebula.com",port:"10800")
              @products = client.query("SELECT * FROM PRODUCTS")
              return @products
            end
            
            post :IgniteCreateProduct do
              client = Ignite::Client.new(username: "e-shop-ignite", password: "eshopignite123",host:"2b07e895-1621-4111-bee3-354ae7ba8602.gridgain-nebula.com",port:"10800")
              $i = client.query("SELECT COUNT(ID) FROM PRODUCTS")
              $c = $i[0]["COUNT(ID)"]
              $crand = $c + rand(777)
              $id = Random.rand($c...$crand)
              client.query("INSERT INTO PUBLIC.PRODUCTS(ID, NAME, PRICE, SUBCATEGORY_ID, BRAND_ID, QUANTITY, DESCRIPTION)VALUES(#{$id}, '#{Faker::Commerce.product_name}', #{Faker::Number.between(1, 100)}, #{Faker::Number.between(8, 50)}, #{Faker::Number.between(6, 10)}, 100, '#{Faker::Commerce.department(2, true)}')")
              @products = client.query("SELECT * FROM PRODUCTS")# WHERE ID = #{$id}")
              return @products
            end
            #UPDATE PRODUCT QUANTITY
            put :UpdateProduct do
              product = Product.find(params[:id])
              if product == nil
                return "No Product is available "
              else
                product.update(
                    name: params[:name],
                    price: params[:price], 
                    description: params[:description],
                    brand_id: params[:brand_id],  
                    quantity: params[:quantity],  
                    availability: params[:availability],  
                    subcategory_id: params[:subcategory_id],
                )
                return product
              end
            end

            #CREATES A NEW PRODUCTs 
            post :CreateProduct do
                product = Product.new(
                    name: params[:name],
                    price: params[:price], 
                    description: params[:description],
                    brand_id: params[:brand_id],  
                    quantity: params[:quantity],  
                    availability: params[:availability],  
                    subcategory_id: params[:subcategory_id],
                )
                if product.save
                    return "New Product Added in database"
                else
                    return "Somethig Went Wrong due to wrong or empty params"
                end
            end

            #DELETE ANY PRODUCT OF ANY BRAND
            delete do
              Product.find(params[:id]).delete
              return "Product Deleted"
            end

          end
      end
    end
  end
