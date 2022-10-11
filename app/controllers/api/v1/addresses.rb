module API
    module V1
      class Addresses < Grape::API
          version 'v1', using: :path
          format :json
          prefix :api
          resource :addresses do
            desc 'Return all Addresses'

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

            #GET ALL ADDRESSES
            get :GetAll do 
                Address.all
            end

            #DELETE ANY SHOPPER ADDRESS
            delete do
              Address.where(id: params[:id]).delete
              return "Address Deleted"
            end

          end
      end
    end
  end
