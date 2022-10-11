# class XyzController < ApplicationController
#     def index
#         client = Ignite::Client.new
#         if (shopper = client.query("SELECT ID, NAME FROM SHOPPERS WHERE EMAIL= '#{login_params[:email]}' AND PASS='#{login_params[:password]}'")) != []
#             Redis.current.mset("shopper_id","#{shopper[0]["ID"]}", "shopper_name","#{shopper[0]["NAME"]}", "shopper_email","#{login_params[:email]}")
#             puts"=======================REDIS SAVED SHOPPER ID: #{Redis.current.get("shopper_email")}===================="
#             EmailJob.perform_now(1)
#             ActionCable.server.broadcast('room_channel', { body: 'shopper login the system' })
#             redirect_to '/addresses'
#         elsif (company = client.query("SELECT * FROM COMPANIES WHERE EMAIL='#{login_params[:email]}' AND PASSWORD_DIGEST= '#{login_params[:password]}'")) != []
#             Redis.current.mset("company_id","#{company[0]["ID"]}", "company_name","#{company[0]["NAME"]}", "company_email","#{login_params[:email]}")            
#             puts"=======================REDIS SAVED COMPANY ID: #{Redis.current.get("company_id")}===================="            
#             puts"=======================REDIS SAVED COMPANY NAME: #{Redis.current.get("company_name")} \nREDIS SAVED COMPANY EMAIL: #{Redis.current.get("company_email")} ===================="            
#             EmailJob.perform_now(1)
#               ActionCable.server.broadcast('room_channel', { body: 'company login the system' })
#             redirect_to '/brands'
#         elsif (retailer = client.query("SELECT * FROM RETAILERS WHERE EMAIL='#{login_params[:email]}' AND PASS= '#{login_params[:password]}'")) != []
#             Redis.current.mset("retailer_id","#{retailer[0]["ID"]}", "retailer_name","#{retailer[0]["NAME"]}", "retailer_email","#{login_params[:email]}")
#             puts"=======================REDIS SAVED RETAILER ID: #{Redis.current.get("retailer_id")} \nREDIS SAVED RETAILER NAME: #{Redis.current.get("retailer_name")} ======================="
#             EmailJob.perform_now(1) 
#               ActionCable.server.broadcast('room_channel', { body: 'retailer login the system' })
#             redirect_to '/orders'
#         else
#             puts "=========== PLEASE ENTER CORRECT CREDENTIALS NO USER FOUND ============"
#             flash[:login_errors] = ['invaild credentials']
#             ActionCable.server.broadcast('room_channel', { body: 'Alert!! A wrong person is trying to access your system' })

#             redirect_to '/'
#         end
#         return
#     end
    
#     private 
#      def login_params
#         params.require(:login).permit(:email, :password)
#      end

# end

################################################################################################################################
class XyzController < ApplicationController
    def index
        puts " -===================== THIS ONE IS REAL ONE NOT DEVISE ONE =======================- "
        if (shopper = Shopper.where(email:login_params[:email]).pluck(:id, :name, :pass)) != []
            if shopper[0][2] ==  login_params[:password]
                puts"---------------- YES LOGIN IS CALLED USING SHOPPER PARAMS OF #{shopper[0][1]} ---------------" 
                Redis.current.mset("shopper_id","#{shopper[0][0]}", "shopper_name","#{shopper[0][1]}", "shopper_email","#{login_params[:email]}")
                puts"=======================REDIS SAVED SHOPPER ID: #{Redis.current.get("shopper_email")}===================="
                # EmailJob.perform_now(1)
                redirect_to '/addresses'
            else
                flash[:login_errors] = ['invaild credentials']
                redirect_to '/'
            end
        elsif (company = Company.where(email:login_params[:email]).pluck(:id, :name, :password_digest)) != []
            if company[0][2] ==  login_params[:password]
                puts"---------------- YES LOGIN IS CALLED USING COMPANY PARAMS OF #{company[0][1]}"
                Redis.current.mset("company_id","#{company[0][0]}", "company_name","#{company[0][1]}", "company_email","#{login_params[:email]}")            
                puts"=======================REDIS SAVED COMPANY ID: #{Redis.current.get("company_id")}===================="            
                puts"=======================REDIS SAVED COMPANY NAME: #{Redis.current.get("company_name")} \nREDIS SAVED COMPANY EMAIL: #{Redis.current.get("company_email")} ===================="            
                # EmailJob.perform_now(1)
                redirect_to '/brands'
            else
               flash[:login_errors] = ['invaild credentials']
               redirect_to '/'
            end
        elsif (retailer = Retailer.where(email:login_params[:email]).pluck(:id, :name, :pass)) != []
            if retailer[0][2] ==  login_params[:password]
                puts"---------------- YES LOGIN IS CALLED USING RETAILER PARAMS OF #{retailer[0][1]} ---------------"
                Redis.current.mset("retailer_id","#{retailer[0][0]}", "retailer_name","#{retailer[0][1]}", "retailer_email","#{login_params[:email]}")
                puts"=======================REDIS SAVED RETAILER ID: #{Redis.current.get("retailer_id")} \nREDIS SAVED RETAILER NAME: #{Redis.current.get("retailer_name")} ======================="
                # EmailJob.perform_now(1) 
                redirect_to '/orders'
            else
                puts "=========== PLEASE ENTER CORRECT CREDENTIALS ============"
                flash[:login_errors] = ['invaild credentials']
                redirect_to '/'
            end
        else
            puts "=========== PLEASE ENTER CORRECT CREDENTIALS NO USER FOUND ============"
            flash[:login_errors] = ['invaild credentials']
            redirect_to '/'
        end
        return
    end
    
    private 
     def login_params
        params.require(:login).permit(:email, :password)
     end

end




# # client.query("INSERT INTO PUBLIC.SHOPPERS(ID, PHONE, NAME, EMAIL, PASS, CREATED_AT, UPDATED_AT)VALUES(#{$i},#{Faker::PhoneNumber.extension}, '#{Faker::Name.gender_neutral_first_name}', '#{Faker::Internet.email}', '#{Faker::Internet.password}','2022-08-23 07:12:18.811','2022-08-23 07:12:18.811');")

# # client.query("INSERT INTO PUBLIC.BRANDS(ID, NAME, SLOGAN, COMPANY_ID, CREATED_AT, UPDATED_AT)VALUES(#{Faker::Number.rand_in_range(1,40)}, '#{Faker::Company.name}', '#{Faker::Company.bs}',#{Faker::Number.rand_in_range(1,40)},'2022-08-23 07:12:18.811','2022-08-23 07:12:18.811');")

# # client.query("INSERT INTO PUBLIC.BRANDS(ID, NAME, TAG_LINE, COMPANY_ID, CREATED_AT, UPDATED_AT)VALUES(#{Faker::Number.rand_in_range(1,40)}, '#{Faker::Company.name}', '#{Faker::Company.bs}', #{Faker::Number.rand_in_range(1,40)}, '2022-08-23 07:12:18.811', '2022-08-23 07:12:18.811');")

# # client.query("INSERT INTO PUBLIC.COMPANIES(ID, NAME, EMAIL, PASSWORD_DIGEST, SLOGAN, CREATED_AT, UPDATED_AT)VALUES(#{Faker::Number.rand_in_range(1,40)}, '#{Faker::Company.name}', '#{Faker::Internet.email}', '#{Faker::Internet.password}', '#{Faker::Company.bs}', '2022-08-23 07:12:18.811', '2022-08-23 07:12:18.811');")

# # client.query("INSERT INTO PUBLIC.PRODUCTS(ID, NAME, PRICE, BRAND_ID, QUANTITY, AVAILABILITY, SUBCATEGORY_ID, CREATED_AT, UPDATED_AT, DETAILS)VALUES($i, '#{Faker::Commerce.product_name}', #{Faker::Commerce.price}, #{Faker::Number.rand_in_range(1,40)}, 100, true, #{Faker::Number.rand_in_range(1,40)}, '2022-08-23 07:12:18.811', '2022-08-23 07:12:18.811', '#{Faker::Commerce.department}');")
# # client.query("INSERT INTO PUBLIC.PRODUCTS(ID, NAME, PRICE, BRAND_ID, QUANTITY, AVAILABILITY, SUBCATEGORY_ID, CREATED_AT, UPDATED_AT, DETAILS)VALUES(1, '#{Faker::Commerce.product_name}', #{Faker::Commerce.price}, #{Faker::Number.rand_in_range(1,40)}, 100, true, #{Faker::Number.rand_in_range(1,40)}, '2022-08-23 07:12:18.811', '2022-08-23 07:12:18.811', '#{Faker::Commerce.department}');")


# # $a=Faker::Address.secondary_address
# # $b=Faker::Address.street_address
# # $c=Faker::Address.city
# # $d=Faker::Address.country
# # $add = "#{$a}, #{$b}, #{$c}, #{$d}"
# # client.query("INSERT INTO PUBLIC.RETAILERS(ID, PHONE, NAME, EMAIL, PASS, LOCATION)VALUES(#{$i}, #{Faker::PhoneNumber.extension}, '#{Faker::Company.name}', '#{Faker::Internet.email}', '#{Faker::Internet.password}', '#{$addr}');")



# 30.times do
#   $i +=1
#   dep = Faker::Commerce.department(max: 1)
#   a = client.query("SELECT NAME FROM SUBCATEGORIES WHERE NAME = '#{dep}'")
#   $j = 0
#   while a != [] || $j ==27
#     a = [];
#     dep = Faker::Commerce.department(max: 1)  
#     a = client.query("SELECT NAME FROM SUBCATEGORIES WHERE NAME = '#{dep}'")
#     puts " CATEGORY FOUND: #{a}"
#     $j += 1
#   end
#   client.query("INSERT INTO PUBLIC.SUBCATEGORIES(ID, NAME, CATEGORY_ID)VALUES(#{$i}, '#{dep}');")
# end





