
class ProductsController < ApplicationController
  # before_action :require_user
  # before_action :set_product, only: %i[ show edit update destroy ]
  # GET companies/id?/products or /companies/id?/products.json
 def search
  query = params[:search_products].presence && params[:search_products][:query]

if query
  @products = Product.search_published(query)
end
 end
 
  def index
  client = Ignite::Client.new(username: " USERNAME ", password: " PASSWORD ",host:" HOST NAME",port:"10800")
  @products = client.query("SELECT * FROM PRODUCTS")
  respond_to do |format|
       format.html  # index.html.erb
       format.json  { render :json => @products }
   end
  end
  # GET /companies/id?/products/1 or /companies/id?/products/1.json
  def show
    storage = Google::Cloud::Storage.new(
       project_id: " ID ",
       credentials: "../keyfile.json"
     )
    
    bucket = storage.bucket " "
      @product = Product.find(params[:id])
      if (file = bucket.file "#{@product.id}.jpg")
        @url = " URL"
      else
        @url = " URL"
      end
  end
  def new
      @product = Product.new
      puts "#{@product}"
      respond_to do |format|
        format.html  # new.html.erb
        format.json  { render :json => @product }
      end
  end
  # POST /products/new
  def create
      @product = Product.new(product_params)
      # @product[:brand_id] = 99
      @product.brand_id =  Redis.current.get("brand_id")
      $val = @product.availability
      # @product.availability = $val.to_b
      respond_to do |format|
          if @product.save
            file_data = product_params_image[:image].tempfile.path
    storage = Google::Cloud::Storage.new(
       project_id: " ID",
       credentials: "../keyfile.json"
     )
    
    bucket = storage.bucket " "
    file = bucket.create_file file_data , "#{@product.id}.jpg"
              format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
              format.json { render :show, status: :created, location: @product }
          else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @product.errors, status: :unprocessable_entity }
          end

         
      end
    end

    # GET /companies/id?/products/1/edit
def edit
  @product = Product.find(params[:id])
end
# PATCH/PUT /companies/id?/products/1 or /companies/id?/products/1.json
def update
  if(Redis.current.get("shopper_id") == nil)
    puts"-==========COMPANY IS LOGGED IN =============-"
    respond_to do |format|
      if @product.update(product_params)
        file_data = product_params_image[:image].tempfile.path
        storage = Google::Cloud::Storage.new(
          project_id: " ",
          credentials: "../keyfile.json"
        )
        bucket = storage.bucket " "
        file = bucket.create_file file_data , "#{@product.id}.jpg"
        format.html { redirect_to product_url(@product), notice: "Product was updated successfully." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
      return 
    end
  else
  puts"-~~~~~~~~~~~~~~~~~~~~~ USER IS LOGGED IN #{Redis.current.get("shopper_id")} -~~~~~~~~~~~~~~~~~~~~~"
    prod_qty=product_params[:quantity]
    # @cart = Cart.where(shopper_id: Redis.current.get("shopper_id")).first
    client = Ignite::Client.new
    count = client.query("SELECT COUNT(ID) FROM CARTS")
    $ID = count[0]["COUNT(ID)"] + 1
    # @product = Product.find(params[:id])  
    @product = client.query("SELECT * FROM PRODUCTS WHERE ID = #{params[:id]}")
    $cart_total = @product[0]["PRICE"] * prod_qty.to_i
    Redis.current.set("cart_#{$ID}_total","#{$cart_total}")
    Redis.current.set("cart_id","#{$ID}")
    client.query("INSERT INTO PUBLIC.CARTS(ID, TOTAL, SHOPPER_ID, QTY, ORDER_ID, PRODUCT_NAME, PRODUCT_PRICE)VALUES(#{$ID}, #{$cart_total}, #{Redis.current.get("shopper_id")},#{prod_qty.to_i},0, '#{@product[0]["NAME"]}', #{@product[0]["PRICE"].to_i})")
     end
end



# DELETE /companies/id?/products/1 or /companies/id?/products/1.json
def destroy
  @product.destroy
  respond_to do |format|
    format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
    format.json { head :no_content }
  end
end
private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    # @product = Product.find(params[:id])
    client = Ignite::Client.new
    @product = client.query("SELECT * FROM PRODUCTS WHERE ID = #{params[:id]}")
    # @brand = Brand.find(@product.brand_id)
    @brand = client.query("SELECT * FROM BRANDS WHERE ID = #{@product[0]["BRAND_ID"]}")
    # @company = Company.find(@brand.company_id)
    @company = client.query("SELECT * FROM COMPANIES WHERE ID = #{@brand[0]["COMPANY_ID"]}")
    Redis.current.set("product_id","#{@product[0]["ID"]}")
    puts"========= REDIS SAVED PRODUCT ID #{Redis.current.get("product_id")} ========="
    Redis.current.set("company_id","#{@company[0]["ID"]}")
    puts"========= REDIS SAVED COMPANY ID #{Redis.current.get("company_id")} ========="
  end
  # Only allow a list of trusted parameters through.
  def product_params_image
    params.require(:product).permit(:name, :description, :price, :brand_id, :availability, :quantity, :subcategory , :image)
  end
  def product_params
    params.require(:product).permit(:name, :description, :price, :brand_id, :availability, :quantity, :subcategory)
  end
end
