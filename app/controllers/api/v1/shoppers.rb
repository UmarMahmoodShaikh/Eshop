module API
    module V1
      class Shoppers < Grape::API
          version 'v1', using: :path
          format :json
          prefix :api
          resource :shoppers do
            desc 'Return all Shoppers'

            #GET ALL SHOPPERS
            get :GetAll do 
              @shopper = Shopper.all
              if !@shopper
                return "No Shopper Found"
              else
                return @shopper
              end
            end
             
             #GET ALL ADDRESSES OF A CERTAIN SHOPPER
            get :ShopperAddr do
              Address.where(shopper_id: params[:shopper_id])
              addr = Address.where(shopper_id: params[:shopper_id])
              if addr == []
                return "Address Not Found with given Shopper ID"
              else
                return addr
              end
            end
            #GET A SPECIFIC SHOPPERS
            get :Shopper do
              puts "SHOPPER LOGGIN IN"
              shopper = Shopper.where(email: params[:email], pass: params[:pass])
              if shopper == []
                return "Shopper Not Found with given Params"
              else
                # red = Redis.new
                # abc=red.set("shopper_id","#{@shopper[0].id}")
                # red.set("shopper_name","#{@shopper[0].name}")
                # puts "SHOPPER FOUND AND SAVED IN REDIS #{red.get("shopper_name")}"
                # # redirect '/addresses'
               
                return shopper
              end
            end

            #CREATES A NEW SHOPPER 
            post :CreateShopper do
                shopper = Shopper.new(
                    name: params[:name],
                    email: params[:email], 
                    pass: params[:pass],
                    phone: params[:phone],  
                )
                if shopper.save
                    return "New Shopper Added"
                else
                    return "Somethig Went Wrong due to wrong params"
                end
            end

            #LOGI SHOPPER AND ADD THEIR ADDRESS
            post :LoginShopperAddr do
                shopper = Shopper.find_by(email: params[:email] , pass: params[:pass])
                if(shopper != nil)
                    addr = Address.new(
                        name: params[:address_name],
                        detail: params[:address_detail],
                        shopper_id: shopper.id
                    )
                    addr.save
                    return "Shopper SignedUp Successfully and New Address Saved"
                else
                    return "Wrong Params Passed"
                end
            end


            #DELETE ANY SHOPPER 
            delete do
              Shopper.where(email: params[:email], pass: params[:pass]).destroy_all
              return "Shopper Deleted"
            end

          end
      end
    end
  end
