class CartsController < ApplicationController
  # before_action :require_user
  before_action :set_cart, only: %i[ show edit update destroy ]
  # GET /carts or /carts.json
  def index
    @carts = Cart.where(shopper_id: Redis.current.get("shopper_id"))
  end

  # GET /carts/1 or /carts/1.json
  def show
    @cart = Cart.find(params[:id])
    Redis.current.set("cart_total-#{@cart.id}", "#{@cart.total}")
    @gt = Redis.current.get("cart_total-#{@cart.id}")
  end

  # GET /carts/new
  def new
    @cart = Cart.new
    puts"============= #{params[:id]}=============="
    @product = Product.find(params[:id])
  end
  def newCart(id)
    @cart = Cart.new
    @product = Product.find(prams[:id])
    puts"============= #{@product}=============="

  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts or /carts.json
  def create(product_params)
    puts"============= #{product_params[:id]}=============="
    prod_qty=product_params[:quantity]
    @cart = Cart.where(shopper_id: Redis.current.get("shopper_id")).first
    if (@cart == nil)
      puts "Cart not found creating a New cart"  
      puts"============= #{product_params[:id]}=============="
      @cart=Cart.newCart(product_params[:id])
      @cart.qty += prod_qty.to_i
      @product = Product.find(params[:id])
      @cart.total = @product.price * prod_qty.to_i
      Redis.current.set("cart_#{@cart.id}_total","#{@cart.total}")
      Redis.current.set("cart_id","#{@cart.id}")
      @cart.shopper_id= Redis.current.get("shopper_id")
      $prod = [
        {
          "product_id" => "#{@product.id}",
          "product_name" => "#{@product.name}",
          "product_qty" => "#{prod_qty.to_i}",  
          "product_total" => "#{@product.price * prod_qty.to_i}",
          "retailer_id" => "#{Redis.current.get("retailer_id")}",
          "status" => "false"
        }
      ]
      @cart.products = prod
      @cart.save
      if @cart.save
        format.html { redirect_to cart_url(@cart), notice: "Added to cart" }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    else
      puts "Cart already exists"
      @cart.qty += prod_qty.to_i
      @product = Product.find(params[:id])
      @prod_total = @product.price * prod_qty.to_i
      @cart.total += @prod_total
      Redis.current.set("cart_#{@cart.id}_total","#{@cart.total}")
      prod = @cart.products + [
        {
          "product_id" => "#{@product.id}",
          "product_name" => "#{@product.name}",
          "product_qty" => "#{prod_qty.to_i}",
          "product_total" => "#{@product.price * prod_qty.to_i}",
          "retailer_id" => "#{Redis.current.get("retailer_id")}",
          "status" => "false"
        }
      ]

      @cart.products = prod
      @cart.products = "#{@cart.products}"+"#{obj1}"
      @cart.save
      puts "-=========PRODUCT IN CART AS: #{@cart.products}==========-"
      respond_to do |format|
        if @cart.save
          format.html { redirect_to cart_url(@cart), notice: "Add to cart" }
          format.json { render :show, status: :created, location: @cart }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @cart.errors, status: :unprocessable_entity }
        end
      end
    end
    # respond_to do |format|
    #   if @cart.save
    #     format.html { redirect_to cart_url(@cart), notice: "Cart was successfully created." }
    #     format.json { render :show, status: :created, location: @cart }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @cart.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
      Redis.current.set("cart_id","#{@cart.id}")
      puts "=================== REDIS IS SAVED WITH CART ID #{Redis.current.get("cart_id)")} ======================"
      # @product = Product.find(params[Redis.current.get("product_id")])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:total, :qty)
    end
end
