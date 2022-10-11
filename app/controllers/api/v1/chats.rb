module API
    module V1
      class Chats < Grape::API
          version 'v1', using: :path
          format :json
          prefix :api
          resource :chats do
            desc 'Return all Chats'

            #GET ALL CHATS
            get :GetAll do 
                Chat.all
            end

            #DELETE ANY CHAT
            delete do
              Chat.where(id: params[:id]).delete
              return "Chats Deleted"
            end

          end
      end
    end
  end
