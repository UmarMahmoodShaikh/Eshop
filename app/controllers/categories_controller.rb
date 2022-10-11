class CategoriesController < ApplicationController
  # before_action :require_user
  before_action :set_category, only: %i[ show edit update destroy ]
  # GET /categories or /categories.json
  def index
    # client = Ignite::Client.new
    # @categories = client.query("SELECT * FROM CATEGORIES")
    @categories = Category.all
    @cart = Cart.where(shopper_id: Redis.current.get("shopper_id"))
    # @cart = client.query("SELECT * FROM CARTS WHERE SHOPPER_ID = #{Redis.current.get("shopper_id")} AND ORDER_ID = 0")
    puts "~~~~~~~~~~~~~~~~~~~~~~~~#{@cart[0]}  ~~~~~~~~~~~~~~~~~~~~~~~~"
    if(@cart[0] == nil)
      @prods = "Cart is empty"
    else
      @prods = ActiveSupport::JSON.decode("#{@cart[0].products.to_json}")
      # @prods = "#{@cart[0]["ITEMS"]}"
    end
    # @ordersPending = client.query("SELECT * FROM ORDERS WHERE SHOPPER_ID = #{Redis.current.get("shopper_id")} AND STATUS = 1")
    # @ordersCompleted = client.query("SELECT * FROM ORDERS WHERE SHOPPER_ID = #{Redis.current.get("shopper_id")} AND STATUS = 2")
    @ordersPending = Order.where(shopper_id: Redis.current.get("shopper_id"), status: '0')
    @ordersCompleted = Order.where(shopper_id: Redis.current.get("shopper_id"), status: '1')

  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to category_url(@category), notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
      # client = Ignite::Client.new
      # @category = client.query("SELECT * FROM CATEGORIES WHERE ID = #{params[:id]}")
      Redis.current.set("category_id","#{@category.id}")
      Redis.current.set("category_name","#{@category.name}")
      # @subcategory = client.query("SELECT * FROM SUBCATEGORIES WHERE CATEGORY_ID = #{Redis.current.get("category_id")}")
      @subcategory = Subcategory.where(category_id: Redis.current.get("category_id"))
      @cart = Cart.where(shopper_id: Redis.current.get("shopper_id"))
      # @cart = client.query("SELECT * FROM CARTS WHERE SHOPPER_ID = #{Redis.current.get("shopper_id")}")
      puts "~~~~~~~~~~~~~~~~~~~~~~~~#{@cart[0]}  ~~~~~~~~~~~~~~~~~~~~~~~~"
      @ordersPending = Order.where(shopper_id: Redis.current.get("shopper_id"), status: '0')
      @ordersCompleted = Order.where(shopper_id: Redis.current.get("shopper_id"), status: '1')
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
